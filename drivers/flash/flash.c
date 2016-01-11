//
// this file implements the low level flash control and access.
//
// This file originated from the cpustick.com skeleton project from
// http://www.cpustick.com/downloads.htm and was originally written
// by Rich Testardi; please preserve this reference and share bug
// fixes with rich@testardi.com.
// KeithV (Digilent) 6/10/2012 Modified for Just-In-Time-Flash-Erase; moved to main.c

/***    void flashOperation(uint32 nvmop, uint32 addr, uint32 data)
**
**    Synopsis:
**      Performs either a page erase, word write, or row write
**
**    Parameters:
**      nvmop	either NVMOP_PAGE_ERASE, NVMOP_WORD_PGM, or NVMOP_ROW_PGM
**		addr	the uint32_t flash address of: the page to erase, word location to write, or row location to write
**		data	a uint32_t of data to write, or the uint32_t of the SRAM address containing the array of data to write to the row
**
**    Return Values:
**      True if successful, false if failed
**
**    Errors:
**      None
**
**  Notes:
**      data has no meaning when page erase is specified and should be set to 0ul
**
*/

#include "whitecat.h"

#include <types.h>
#include <machine/pic32mz.h>
#include <machine/machConst.h>

// thing re-written out of plib.h for open source
#define KVA_2_PA(v) 			((v) & 0x1fffffff)
#define PA_2_KVA0(pa)           ((pa) | 0x80000000)  // cachable
#define PA_2_KVA1(pa)           ((pa) | 0xa0000000)
#define UART_RX_ENABLE			(1<<12)					/* Enable RX*/
#define UART_TX_ENABLE         	(1<<10)                 /* Enable TX*/
#define UART_ENABLE             (1<<15)                 /* UART enable */
#define TF_LITTLE(x)            (x)
        
// Flash operations
#define NVMOP_WORD_PGM          0x4001      // Word program operation
#define NVMOP_ROW_PGM           0x4003      // Row write
#define NVMOP_PAGE_ERASE        0x4004      // Page erase operation

#define NVMCON_NVMOP           	0x0000000f
#define NVMCON_ERASE            0x00000040
#define NVMCON_WRERR            0x00002000
#define NVMCON_WREN             0x00004000
#define NVMCON_WR               0x00008000

static void __attribute__((nomips16)) flashOperation(uint32 nvmop, uint32 addr, uint32 data) {
    unsigned long   t0;

    // Convert Address to Physical Address
    NVMADDR = KVA_2_PA(addr);

    NVMDATA0 = data;
    NVMSRCADDR = KVA_2_PA(data);

    // Enable Flash Write/Erase Operations
    NVMCON = NVMCON_WREN | nvmop;

    // this is a poorly documented yet very important
    // required delay on newer silicon.
    // If you do not delay, on some silicon it will
    // completely latch up the flash to where you need
    // to cycle power, so wait for at least
    // 6us for LVD start-up, see errata
    t0 = mfc0_Count();
    while (mfc0_Count() - t0 < ((6 * CPU_HZ) / 2 / 1000000UL));

    // magic unlock sequence
    NVMKEY = 0xAA996655;
    NVMKEY = 0x556699AA;
    NVMCONSET = NVMCON_WR;

    // Wait for WR bit to clear
    while (NVMCON & NVMCON_WR);

    // see errata, wait 500ns before writing to any NVM register
    t0 = mfc0_Count();
    while (mfc0_Count() - t0 < ((CPU_HZ / 2 / 2000000UL)));

    // Disable Flash Write/Erase operations
    NVMCONCLR = NVMCON_WREN;
}

static void flashErasePage(uint32 addrPage) {
    int i;
    int j;
    int32 x = 0xffffffff;
    uint32 *rgUint32 = (uint32 *) addrPage;

    // we learned that just because the flash does not successfully
    // erase on the first attempt, it might on another. We found that
    // we can double the life of flash by attempting to
    // erase the flash up to 5 times before quitting.
    for(j=0; j<5; j++)
    {
    	// first check to see if the page needs to be erased
       	for (i = 0; i < FLASH_PAGE_SIZE/sizeof(uint32); i++) 
    	{
    		x &= rgUint32[i];
    	}
    	
        // flash erased, we are done.
        if(x == 0xffffffff)
        {
            break;
        } 
	
        // Unlock and Erase Page
        flashOperation(NVMOP_PAGE_ERASE, addrPage, 0);
    }

    // at this point, we don't care if the flash ever actually erased as
    // as we will catch the failure when we verify the programming.
 }

/***    void flashWriteUint32(uint32 addrUint32, uint32 *rgu32Data, uint32 cu32Data)
**
**    Synopsis:   
**      Writes an array to uint32 to flash
*
**    Parameters:
**      rgu32Data	Pointer to an array of uint32
**		cu32Data	The number of uint32 to write
**
**    Return Values:
**      None
**
**    Errors:
**      None
**
**  Notes:
**
**      Assumes the pages have already been erased.
**
*/
static void flashWriteUint32(uint32 addrUint32, uint32 *rgu32Data, uint32 cu32Data)
{
    int  i = 0;

    for(i=0; i < cu32Data; i++) 
	{

		// only do this if the data is not what is already in flash
		if(rgu32Data[i] != 0xffffffff)
		{	
	        // Write the data
	        flashOperation(NVMOP_WORD_PGM, addrUint32, rgu32Data[i]);
		}

        addrUint32 += sizeof(uint32);
    }
}

/***    void justInTimeFlashErase(uint32 addrLow, uint32 addrHigh)
**
**    Synopsis:   
**      Erases all pages that have not been erased in the address range
*
**    Parameters:
**      addrLow:	low virtual address of where the page needs erased
**		addrHigh	1 + the last high byte to be erased.
**
**    Return Values:
**      None
**
**    Errors:
**      None
**
**  Notes:
**
**      The address do not need to be page aligned.
**
*/
static void justInTimeFlashErase(uint32 addrLow, uint32 addrHigh)
{
	uint32 addrCurPage 		= startOfFlashPage(addrLow);
	uint32 addrLastPage 	= nextFlashPage(addrHigh - 1);
	uint32 iPage 			= getPageIndex(addrCurPage);

	while(addrCurPage < addrLastPage)
	{
		// if this has never been erased, erase it.
		if(pageMap[iPage] == 0)
		{
			flashErasePage(addrCurPage);
			pageMap[iPage] = 1;
		}

		iPage++;
		addrCurPage += FLASH_PAGE_SIZE;
	}
}
