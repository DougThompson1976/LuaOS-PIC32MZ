#include "platform_conf.h"


static void i2c_init()
{
}

u32 i2c_setup( u32 speed )
{
    return 0;
}

void i2c_start_cond(void)
{
}

void i2c_stop_cond(void)
{
}

/* Write a bit to I2C bus */
static void i2c_write_bit(int bit)
{
}

/* Read a bit from I2C bus */
static int i2c_read_bit(void)
{
    return 0;
}

/* Write a byte to I2C bus.
 * Returns the nack bit received from the slave: 0 if acknowledged.
 */
int i2c_write_byte(unsigned char byte)
{
    return 0;
}

/* Read a byte from I2C bus.
 * "nack" is the acknowledge bit to send: 0 to acknowledge, 1 to reject/stop.
 */
unsigned char i2c_read_byte(int nack)
{
    return 0;
}

int i2c_send(u8 address, const u8 *data, unsigned len, int stop)
{
    return 0;
}

// i2c_recv() reads "count" bytes from a 7-bit slave device.
// It returns the number of bytes sent or -1 if the slave did not acknowledge its address.
int i2c_recv(u8 address, u8 *data, unsigned len, int stop)
{
    return 0;
}

// See whether a certain slave is present by writing 0 bytes from it.
// Returns 1 if it is present or 0 if it didn't acknowledge its address.
int i2c_probe(u8 slave_address)
{
  return 0;
}
