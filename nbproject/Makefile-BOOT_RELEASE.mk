#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=mips-elf-gcc
CCC=mips-elf-g++
CXX=mips-elf-g++
FC=gfortran
AS=mips-elf-as

# Macros
CND_PLATFORM=GNU-MIPS-MacOSX
CND_DLIB_EXT=dylib
CND_CONF=BOOT_RELEASE
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/FreeRTOS/common/croutine.o \
	${OBJECTDIR}/FreeRTOS/common/event_groups.o \
	${OBJECTDIR}/FreeRTOS/common/heap_4.o \
	${OBJECTDIR}/FreeRTOS/common/list.o \
	${OBJECTDIR}/FreeRTOS/common/queue.o \
	${OBJECTDIR}/FreeRTOS/common/tasks.o \
	${OBJECTDIR}/FreeRTOS/common/timers.o \
	${OBJECTDIR}/FreeRTOS/port/port.o \
	${OBJECTDIR}/FreeRTOS/thread.o \
	${OBJECTDIR}/Lua/5.3.1/lapi.o \
	${OBJECTDIR}/Lua/5.3.1/lauxlib.o \
	${OBJECTDIR}/Lua/5.3.1/lbaselib.o \
	${OBJECTDIR}/Lua/5.3.1/lbitlib.o \
	${OBJECTDIR}/Lua/5.3.1/lcode.o \
	${OBJECTDIR}/Lua/5.3.1/lcorolib.o \
	${OBJECTDIR}/Lua/5.3.1/lctype.o \
	${OBJECTDIR}/Lua/5.3.1/ldblib.o \
	${OBJECTDIR}/Lua/5.3.1/ldebug.o \
	${OBJECTDIR}/Lua/5.3.1/ldo.o \
	${OBJECTDIR}/Lua/5.3.1/ldump.o \
	${OBJECTDIR}/Lua/5.3.1/lfunc.o \
	${OBJECTDIR}/Lua/5.3.1/lgc.o \
	${OBJECTDIR}/Lua/5.3.1/linit.o \
	${OBJECTDIR}/Lua/5.3.1/liolib.o \
	${OBJECTDIR}/Lua/5.3.1/llex.o \
	${OBJECTDIR}/Lua/5.3.1/lmathlib.o \
	${OBJECTDIR}/Lua/5.3.1/lmem.o \
	${OBJECTDIR}/Lua/5.3.1/loadlib.o \
	${OBJECTDIR}/Lua/5.3.1/lobject.o \
	${OBJECTDIR}/Lua/5.3.1/lopcodes.o \
	${OBJECTDIR}/Lua/5.3.1/loslib.o \
	${OBJECTDIR}/Lua/5.3.1/lparser.o \
	${OBJECTDIR}/Lua/5.3.1/lstate.o \
	${OBJECTDIR}/Lua/5.3.1/lstring.o \
	${OBJECTDIR}/Lua/5.3.1/lstrlib.o \
	${OBJECTDIR}/Lua/5.3.1/ltable.o \
	${OBJECTDIR}/Lua/5.3.1/ltablib.o \
	${OBJECTDIR}/Lua/5.3.1/ltm.o \
	${OBJECTDIR}/Lua/5.3.1/lua.o \
	${OBJECTDIR}/Lua/5.3.1/luac.o \
	${OBJECTDIR}/Lua/5.3.1/lundump.o \
	${OBJECTDIR}/Lua/5.3.1/lutf8lib.o \
	${OBJECTDIR}/Lua/5.3.1/lvm.o \
	${OBJECTDIR}/Lua/5.3.1/lzio.o \
	${OBJECTDIR}/Lua/elua/src/common_tmr.o \
	${OBJECTDIR}/Lua/elua/src/linenoise.o \
	${OBJECTDIR}/Lua/elua/src/platform/pic32mz/platform.o \
	${OBJECTDIR}/Lua/modules/adc.o \
	${OBJECTDIR}/Lua/modules/can.o \
	${OBJECTDIR}/Lua/modules/cpu.o \
	${OBJECTDIR}/Lua/modules/gps.o \
	${OBJECTDIR}/Lua/modules/mqtt.o \
	${OBJECTDIR}/Lua/modules/net.o \
	${OBJECTDIR}/Lua/modules/pd.o \
	${OBJECTDIR}/Lua/modules/pio.o \
	${OBJECTDIR}/Lua/modules/pwm.o \
	${OBJECTDIR}/Lua/modules/screen/bitmap.o \
	${OBJECTDIR}/Lua/modules/screen/endian.o \
	${OBJECTDIR}/Lua/modules/screen/screen.o \
	${OBJECTDIR}/Lua/modules/spi.o \
	${OBJECTDIR}/Lua/modules/tmr.o \
	${OBJECTDIR}/Lua/modules/uart.o \
	${OBJECTDIR}/Lua/platform/adc.o \
	${OBJECTDIR}/Lua/platform/can.o \
	${OBJECTDIR}/Lua/platform/cpu.o \
	${OBJECTDIR}/Lua/platform/gps.o \
	${OBJECTDIR}/Lua/platform/net.o \
	${OBJECTDIR}/Lua/platform/pio.o \
	${OBJECTDIR}/Lua/platform/pwm.o \
	${OBJECTDIR}/Lua/platform/spi.o \
	${OBJECTDIR}/Lua/platform/uart.o \
	${OBJECTDIR}/drivers/adc/adc.o \
	${OBJECTDIR}/drivers/can/can.o \
	${OBJECTDIR}/drivers/cfi/cfi.o \
	${OBJECTDIR}/drivers/clock/clock.o \
	${OBJECTDIR}/drivers/console/console.o \
	${OBJECTDIR}/drivers/cpu/cpu.o \
	${OBJECTDIR}/drivers/display/ST7735S/ST7735S.o \
	${OBJECTDIR}/drivers/display/display.o \
	${OBJECTDIR}/drivers/display/font.o \
	${OBJECTDIR}/drivers/dma/dma.o \
	${OBJECTDIR}/drivers/gpio/gpio.o \
	${OBJECTDIR}/drivers/gprs/gprs.o \
	${OBJECTDIR}/drivers/gps/gps.o \
	${OBJECTDIR}/drivers/gps/nmea0183.o \
	${OBJECTDIR}/drivers/net/ENC424J600/ENC424J600.o \
	${OBJECTDIR}/drivers/net/ethernetif.o \
	${OBJECTDIR}/drivers/net/phy/phy.o \
	${OBJECTDIR}/drivers/network/network.o \
	${OBJECTDIR}/drivers/pwm/pwm.o \
	${OBJECTDIR}/drivers/sd/sd.o \
	${OBJECTDIR}/drivers/sim908/sim908.o \
	${OBJECTDIR}/drivers/spi/spi.o \
	${OBJECTDIR}/drivers/uart/uart.o \
	${OBJECTDIR}/lib/libc/gen/assert.o \
	${OBJECTDIR}/lib/libc/gen/clock.o \
	${OBJECTDIR}/lib/libc/gen/closedir.o \
	${OBJECTDIR}/lib/libc/gen/crypt.o \
	${OBJECTDIR}/lib/libc/gen/ctermid.o \
	${OBJECTDIR}/lib/libc/gen/ctime.o \
	${OBJECTDIR}/lib/libc/gen/difftime.o \
	${OBJECTDIR}/lib/libc/gen/disklabel.o \
	${OBJECTDIR}/lib/libc/gen/err.o \
	${OBJECTDIR}/lib/libc/gen/errlst.o \
	${OBJECTDIR}/lib/libc/gen/exec.o \
	${OBJECTDIR}/lib/libc/gen/fnmatch.o \
	${OBJECTDIR}/lib/libc/gen/frexp.o \
	${OBJECTDIR}/lib/libc/gen/fstab.o \
	${OBJECTDIR}/lib/libc/gen/fts.o \
	${OBJECTDIR}/lib/libc/gen/getbsize.o \
	${OBJECTDIR}/lib/libc/gen/getcwd.o \
	${OBJECTDIR}/lib/libc/gen/getgrent.o \
	${OBJECTDIR}/lib/libc/gen/getgrouplist.o \
	${OBJECTDIR}/lib/libc/gen/gethostname.o \
	${OBJECTDIR}/lib/libc/gen/getloadavg.o \
	${OBJECTDIR}/lib/libc/gen/getmntinfo.o \
	${OBJECTDIR}/lib/libc/gen/getnetgrent.o \
	${OBJECTDIR}/lib/libc/gen/getpagesize.o \
	${OBJECTDIR}/lib/libc/gen/getpass.o \
	${OBJECTDIR}/lib/libc/gen/getttyent.o \
	${OBJECTDIR}/lib/libc/gen/getusershell.o \
	${OBJECTDIR}/lib/libc/gen/getvfsbyname.o \
	${OBJECTDIR}/lib/libc/gen/isatty.o \
	${OBJECTDIR}/lib/libc/gen/opendir.o \
	${OBJECTDIR}/lib/libc/gen/popen.o \
	${OBJECTDIR}/lib/libc/gen/psignal.o \
	${OBJECTDIR}/lib/libc/gen/readdir.o \
	${OBJECTDIR}/lib/libc/gen/scandir.o \
	${OBJECTDIR}/lib/libc/gen/sethostname.o \
	${OBJECTDIR}/lib/libc/gen/setjmperr.o \
	${OBJECTDIR}/lib/libc/gen/setmode.o \
	${OBJECTDIR}/lib/libc/gen/siglist.o \
	${OBJECTDIR}/lib/libc/gen/signal.o \
	${OBJECTDIR}/lib/libc/gen/sigsetops.o \
	${OBJECTDIR}/lib/libc/gen/sleep.o \
	${OBJECTDIR}/lib/libc/gen/sysctl.o \
	${OBJECTDIR}/lib/libc/gen/syslog.o \
	${OBJECTDIR}/lib/libc/gen/telldir.o \
	${OBJECTDIR}/lib/libc/gen/termios.o \
	${OBJECTDIR}/lib/libc/gen/time.o \
	${OBJECTDIR}/lib/libc/gen/times.o \
	${OBJECTDIR}/lib/libc/gen/timezone.o \
	${OBJECTDIR}/lib/libc/gen/ualarm.o \
	${OBJECTDIR}/lib/libc/gen/uname.o \
	${OBJECTDIR}/lib/libc/gen/unvis.o \
	${OBJECTDIR}/lib/libc/gen/usleep.o \
	${OBJECTDIR}/lib/libc/gen/utime.o \
	${OBJECTDIR}/lib/libc/gen/valloc.o \
	${OBJECTDIR}/lib/libc/gen/vis.o \
	${OBJECTDIR}/lib/libc/gen/wait.o \
	${OBJECTDIR}/lib/libc/gen/wait3.o \
	${OBJECTDIR}/lib/libc/gen/waitpid.o \
	${OBJECTDIR}/lib/libc/locale/ansi.o \
	${OBJECTDIR}/lib/libc/locale/ctype.o \
	${OBJECTDIR}/lib/libc/locale/euc.o \
	${OBJECTDIR}/lib/libc/locale/frune.o \
	${OBJECTDIR}/lib/libc/locale/isctype.o \
	${OBJECTDIR}/lib/libc/locale/lconv.o \
	${OBJECTDIR}/lib/libc/locale/localeconv.o \
	${OBJECTDIR}/lib/libc/locale/mbrune.o \
	${OBJECTDIR}/lib/libc/locale/none.o \
	${OBJECTDIR}/lib/libc/locale/rune.o \
	${OBJECTDIR}/lib/libc/locale/setlocale.o \
	${OBJECTDIR}/lib/libc/locale/table.o \
	${OBJECTDIR}/lib/libc/locale/utf2.o \
	${OBJECTDIR}/lib/libc/quad/adddi3.o \
	${OBJECTDIR}/lib/libc/quad/anddi3.o \
	${OBJECTDIR}/lib/libc/quad/ashldi3.o \
	${OBJECTDIR}/lib/libc/quad/ashrdi3.o \
	${OBJECTDIR}/lib/libc/quad/cmpdi2.o \
	${OBJECTDIR}/lib/libc/quad/divdi3.o \
	${OBJECTDIR}/lib/libc/quad/fixdfdi.o \
	${OBJECTDIR}/lib/libc/quad/fixsfdi.o \
	${OBJECTDIR}/lib/libc/quad/fixunsdfdi.o \
	${OBJECTDIR}/lib/libc/quad/fixunssfdi.o \
	${OBJECTDIR}/lib/libc/quad/floatdidf.o \
	${OBJECTDIR}/lib/libc/quad/floatdisf.o \
	${OBJECTDIR}/lib/libc/quad/floatunsdidf.o \
	${OBJECTDIR}/lib/libc/quad/iordi3.o \
	${OBJECTDIR}/lib/libc/quad/lshldi3.o \
	${OBJECTDIR}/lib/libc/quad/lshrdi3.o \
	${OBJECTDIR}/lib/libc/quad/moddi3.o \
	${OBJECTDIR}/lib/libc/quad/muldi3.o \
	${OBJECTDIR}/lib/libc/quad/negdi2.o \
	${OBJECTDIR}/lib/libc/quad/notdi2.o \
	${OBJECTDIR}/lib/libc/quad/qdivrem.o \
	${OBJECTDIR}/lib/libc/quad/subdi3.o \
	${OBJECTDIR}/lib/libc/quad/ucmpdi2.o \
	${OBJECTDIR}/lib/libc/quad/udivdi3.o \
	${OBJECTDIR}/lib/libc/quad/umoddi3.o \
	${OBJECTDIR}/lib/libc/quad/xordi3.o \
	${OBJECTDIR}/lib/libc/stdio/clrerr.o \
	${OBJECTDIR}/lib/libc/stdio/fclose.o \
	${OBJECTDIR}/lib/libc/stdio/fdopen.o \
	${OBJECTDIR}/lib/libc/stdio/feof.o \
	${OBJECTDIR}/lib/libc/stdio/ferror.o \
	${OBJECTDIR}/lib/libc/stdio/fflush.o \
	${OBJECTDIR}/lib/libc/stdio/fgetc.o \
	${OBJECTDIR}/lib/libc/stdio/fgetln.o \
	${OBJECTDIR}/lib/libc/stdio/fgetpos.o \
	${OBJECTDIR}/lib/libc/stdio/fgets.o \
	${OBJECTDIR}/lib/libc/stdio/fileno.o \
	${OBJECTDIR}/lib/libc/stdio/findfp.o \
	${OBJECTDIR}/lib/libc/stdio/flags.o \
	${OBJECTDIR}/lib/libc/stdio/fopen.o \
	${OBJECTDIR}/lib/libc/stdio/fprintf.o \
	${OBJECTDIR}/lib/libc/stdio/fpurge.o \
	${OBJECTDIR}/lib/libc/stdio/fputc.o \
	${OBJECTDIR}/lib/libc/stdio/fputs.o \
	${OBJECTDIR}/lib/libc/stdio/fread.o \
	${OBJECTDIR}/lib/libc/stdio/freopen.o \
	${OBJECTDIR}/lib/libc/stdio/fscanf.o \
	${OBJECTDIR}/lib/libc/stdio/fseek.o \
	${OBJECTDIR}/lib/libc/stdio/fsetpos.o \
	${OBJECTDIR}/lib/libc/stdio/ftell.o \
	${OBJECTDIR}/lib/libc/stdio/funopen.o \
	${OBJECTDIR}/lib/libc/stdio/fvwrite.o \
	${OBJECTDIR}/lib/libc/stdio/fwalk.o \
	${OBJECTDIR}/lib/libc/stdio/fwrite.o \
	${OBJECTDIR}/lib/libc/stdio/getc.o \
	${OBJECTDIR}/lib/libc/stdio/getchar.o \
	${OBJECTDIR}/lib/libc/stdio/gets.o \
	${OBJECTDIR}/lib/libc/stdio/getw.o \
	${OBJECTDIR}/lib/libc/stdio/makebuf.o \
	${OBJECTDIR}/lib/libc/stdio/mktemp.o \
	${OBJECTDIR}/lib/libc/stdio/perror.o \
	${OBJECTDIR}/lib/libc/stdio/printf.o \
	${OBJECTDIR}/lib/libc/stdio/putc.o \
	${OBJECTDIR}/lib/libc/stdio/putchar.o \
	${OBJECTDIR}/lib/libc/stdio/puts.o \
	${OBJECTDIR}/lib/libc/stdio/putw.o \
	${OBJECTDIR}/lib/libc/stdio/refill.o \
	${OBJECTDIR}/lib/libc/stdio/remove.o \
	${OBJECTDIR}/lib/libc/stdio/rewind.o \
	${OBJECTDIR}/lib/libc/stdio/rget.o \
	${OBJECTDIR}/lib/libc/stdio/scanf.o \
	${OBJECTDIR}/lib/libc/stdio/setbuf.o \
	${OBJECTDIR}/lib/libc/stdio/setbuffer.o \
	${OBJECTDIR}/lib/libc/stdio/setvbuf.o \
	${OBJECTDIR}/lib/libc/stdio/snprintf.o \
	${OBJECTDIR}/lib/libc/stdio/sprintf.o \
	${OBJECTDIR}/lib/libc/stdio/sscanf.o \
	${OBJECTDIR}/lib/libc/stdio/stdio.o \
	${OBJECTDIR}/lib/libc/stdio/tempnam.o \
	${OBJECTDIR}/lib/libc/stdio/tmpfile.o \
	${OBJECTDIR}/lib/libc/stdio/tmpnam.o \
	${OBJECTDIR}/lib/libc/stdio/ungetc.o \
	${OBJECTDIR}/lib/libc/stdio/vfprintf.o \
	${OBJECTDIR}/lib/libc/stdio/vfscanf.o \
	${OBJECTDIR}/lib/libc/stdio/vprintf.o \
	${OBJECTDIR}/lib/libc/stdio/vscanf.o \
	${OBJECTDIR}/lib/libc/stdio/vsnprintf.o \
	${OBJECTDIR}/lib/libc/stdio/vsprintf.o \
	${OBJECTDIR}/lib/libc/stdio/vsscanf.o \
	${OBJECTDIR}/lib/libc/stdio/wbuf.o \
	${OBJECTDIR}/lib/libc/stdio/wsetup.o \
	${OBJECTDIR}/lib/libc/stdlib/abort.o \
	${OBJECTDIR}/lib/libc/stdlib/abs.o \
	${OBJECTDIR}/lib/libc/stdlib/atexit.o \
	${OBJECTDIR}/lib/libc/stdlib/atof.o \
	${OBJECTDIR}/lib/libc/stdlib/atoi.o \
	${OBJECTDIR}/lib/libc/stdlib/atol.o \
	${OBJECTDIR}/lib/libc/stdlib/bsearch.o \
	${OBJECTDIR}/lib/libc/stdlib/calloc.o \
	${OBJECTDIR}/lib/libc/stdlib/div.o \
	${OBJECTDIR}/lib/libc/stdlib/exit.o \
	${OBJECTDIR}/lib/libc/stdlib/getenv.o \
	${OBJECTDIR}/lib/libc/stdlib/getopt.o \
	${OBJECTDIR}/lib/libc/stdlib/getsubopt.o \
	${OBJECTDIR}/lib/libc/stdlib/heapsort.o \
	${OBJECTDIR}/lib/libc/stdlib/labs.o \
	${OBJECTDIR}/lib/libc/stdlib/ldiv.o \
	${OBJECTDIR}/lib/libc/stdlib/malloc.o \
	${OBJECTDIR}/lib/libc/stdlib/merge.o \
	${OBJECTDIR}/lib/libc/stdlib/putenv.o \
	${OBJECTDIR}/lib/libc/stdlib/qsort.o \
	${OBJECTDIR}/lib/libc/stdlib/radixsort.o \
	${OBJECTDIR}/lib/libc/stdlib/rand.o \
	${OBJECTDIR}/lib/libc/stdlib/random.o \
	${OBJECTDIR}/lib/libc/stdlib/setenv.o \
	${OBJECTDIR}/lib/libc/stdlib/strtod.o \
	${OBJECTDIR}/lib/libc/stdlib/strtol.o \
	${OBJECTDIR}/lib/libc/stdlib/strtoq.o \
	${OBJECTDIR}/lib/libc/stdlib/strtoul.o \
	${OBJECTDIR}/lib/libc/stdlib/strtouq.o \
	${OBJECTDIR}/lib/libc/string/bcopy.o \
	${OBJECTDIR}/lib/libc/string/index.o \
	${OBJECTDIR}/lib/libc/string/memccpy.o \
	${OBJECTDIR}/lib/libc/string/memchr.o \
	${OBJECTDIR}/lib/libc/string/memcmp.o \
	${OBJECTDIR}/lib/libc/string/memset.o \
	${OBJECTDIR}/lib/libc/string/rindex2.o \
	${OBJECTDIR}/lib/libc/string/strcasecmp.o \
	${OBJECTDIR}/lib/libc/string/strcat.o \
	${OBJECTDIR}/lib/libc/string/strcoll.o \
	${OBJECTDIR}/lib/libc/string/strcpy.o \
	${OBJECTDIR}/lib/libc/string/strcspn.o \
	${OBJECTDIR}/lib/libc/string/strdup.o \
	${OBJECTDIR}/lib/libc/string/strerror.o \
	${OBJECTDIR}/lib/libc/string/strftime.o \
	${OBJECTDIR}/lib/libc/string/strlcat.o \
	${OBJECTDIR}/lib/libc/string/strlcpy.o \
	${OBJECTDIR}/lib/libc/string/strmode.o \
	${OBJECTDIR}/lib/libc/string/strncat.o \
	${OBJECTDIR}/lib/libc/string/strncmp.o \
	${OBJECTDIR}/lib/libc/string/strncpy.o \
	${OBJECTDIR}/lib/libc/string/strpbrk.o \
	${OBJECTDIR}/lib/libc/string/strsep.o \
	${OBJECTDIR}/lib/libc/string/strspn.o \
	${OBJECTDIR}/lib/libc/string/strstr.o \
	${OBJECTDIR}/lib/libc/string/strtok.o \
	${OBJECTDIR}/lib/libc/string/strxfrm.o \
	${OBJECTDIR}/lib/libc/string/swab.o \
	${OBJECTDIR}/lib/libm/common/atan2.o \
	${OBJECTDIR}/lib/libm/common/sincos.o \
	${OBJECTDIR}/lib/libm/common/tan.o \
	${OBJECTDIR}/lib/libm/common_source/acosh.o \
	${OBJECTDIR}/lib/libm/common_source/asincos.o \
	${OBJECTDIR}/lib/libm/common_source/asinh.o \
	${OBJECTDIR}/lib/libm/common_source/atan.o \
	${OBJECTDIR}/lib/libm/common_source/atanh.o \
	${OBJECTDIR}/lib/libm/common_source/cosh.o \
	${OBJECTDIR}/lib/libm/common_source/erf.o \
	${OBJECTDIR}/lib/libm/common_source/exp.o \
	${OBJECTDIR}/lib/libm/common_source/exp__E.o \
	${OBJECTDIR}/lib/libm/common_source/expm1.o \
	${OBJECTDIR}/lib/libm/common_source/floor.o \
	${OBJECTDIR}/lib/libm/common_source/fmod.o \
	${OBJECTDIR}/lib/libm/common_source/gamma.o \
	${OBJECTDIR}/lib/libm/common_source/j0.o \
	${OBJECTDIR}/lib/libm/common_source/j1.o \
	${OBJECTDIR}/lib/libm/common_source/jn.o \
	${OBJECTDIR}/lib/libm/common_source/lgamma.o \
	${OBJECTDIR}/lib/libm/common_source/log.o \
	${OBJECTDIR}/lib/libm/common_source/log10.o \
	${OBJECTDIR}/lib/libm/common_source/log1p.o \
	${OBJECTDIR}/lib/libm/common_source/log__L.o \
	${OBJECTDIR}/lib/libm/common_source/pow.o \
	${OBJECTDIR}/lib/libm/common_source/sinh.o \
	${OBJECTDIR}/lib/libm/common_source/tanh.o \
	${OBJECTDIR}/lib/libm/ieee/cabs.o \
	${OBJECTDIR}/lib/libm/ieee/cbrt.o \
	${OBJECTDIR}/lib/libm/ieee/support.o \
	${OBJECTDIR}/lib/list/list.o \
	${OBJECTDIR}/lib/pthread/attr.o \
	${OBJECTDIR}/lib/pthread/cleanup.o \
	${OBJECTDIR}/lib/pthread/cond.o \
	${OBJECTDIR}/lib/pthread/create.o \
	${OBJECTDIR}/lib/pthread/join.o \
	${OBJECTDIR}/lib/pthread/key.o \
	${OBJECTDIR}/lib/pthread/mutex.o \
	${OBJECTDIR}/lib/pthread/once.o \
	${OBJECTDIR}/lib/pthread/pthread.o \
	${OBJECTDIR}/lib/pthread/self.o \
	${OBJECTDIR}/lib/pthread/test.o \
	${OBJECTDIR}/lwip/src/api/api_lib.o \
	${OBJECTDIR}/lwip/src/api/api_msg.o \
	${OBJECTDIR}/lwip/src/api/err.o \
	${OBJECTDIR}/lwip/src/api/netbuf.o \
	${OBJECTDIR}/lwip/src/api/netdb.o \
	${OBJECTDIR}/lwip/src/api/netifapi.o \
	${OBJECTDIR}/lwip/src/api/pppapi.o \
	${OBJECTDIR}/lwip/src/api/psockets.o \
	${OBJECTDIR}/lwip/src/api/sockets.o \
	${OBJECTDIR}/lwip/src/api/tcpip.o \
	${OBJECTDIR}/lwip/src/core/def.o \
	${OBJECTDIR}/lwip/src/core/dhcp.o \
	${OBJECTDIR}/lwip/src/core/dns.o \
	${OBJECTDIR}/lwip/src/core/inet_chksum.o \
	${OBJECTDIR}/lwip/src/core/init.o \
	${OBJECTDIR}/lwip/src/core/ipv4/autoip.o \
	${OBJECTDIR}/lwip/src/core/ipv4/icmp.o \
	${OBJECTDIR}/lwip/src/core/ipv4/igmp.o \
	${OBJECTDIR}/lwip/src/core/ipv4/ip4.o \
	${OBJECTDIR}/lwip/src/core/ipv4/ip4_addr.o \
	${OBJECTDIR}/lwip/src/core/ipv4/ip_frag.o \
	${OBJECTDIR}/lwip/src/core/ipv6/dhcp6.o \
	${OBJECTDIR}/lwip/src/core/ipv6/ethip6.o \
	${OBJECTDIR}/lwip/src/core/ipv6/icmp6.o \
	${OBJECTDIR}/lwip/src/core/ipv6/inet6.o \
	${OBJECTDIR}/lwip/src/core/ipv6/ip6.o \
	${OBJECTDIR}/lwip/src/core/ipv6/ip6_addr.o \
	${OBJECTDIR}/lwip/src/core/ipv6/ip6_frag.o \
	${OBJECTDIR}/lwip/src/core/ipv6/mld6.o \
	${OBJECTDIR}/lwip/src/core/ipv6/nd6.o \
	${OBJECTDIR}/lwip/src/core/mem.o \
	${OBJECTDIR}/lwip/src/core/memp.o \
	${OBJECTDIR}/lwip/src/core/netif.o \
	${OBJECTDIR}/lwip/src/core/pbuf.o \
	${OBJECTDIR}/lwip/src/core/raw.o \
	${OBJECTDIR}/lwip/src/core/snmp/asn1_dec.o \
	${OBJECTDIR}/lwip/src/core/snmp/asn1_enc.o \
	${OBJECTDIR}/lwip/src/core/snmp/mib2.o \
	${OBJECTDIR}/lwip/src/core/snmp/mib_structs.o \
	${OBJECTDIR}/lwip/src/core/snmp/msg_in.o \
	${OBJECTDIR}/lwip/src/core/snmp/msg_out.o \
	${OBJECTDIR}/lwip/src/core/sntp.o \
	${OBJECTDIR}/lwip/src/core/stats.o \
	${OBJECTDIR}/lwip/src/core/sys.o \
	${OBJECTDIR}/lwip/src/core/tcp.o \
	${OBJECTDIR}/lwip/src/core/tcp_in.o \
	${OBJECTDIR}/lwip/src/core/tcp_out.o \
	${OBJECTDIR}/lwip/src/core/ticker.o \
	${OBJECTDIR}/lwip/src/core/timers.o \
	${OBJECTDIR}/lwip/src/core/udp.o \
	${OBJECTDIR}/lwip/src/netif/etharp.o \
	${OBJECTDIR}/lwip/src/netif/ppp/auth.o \
	${OBJECTDIR}/lwip/src/netif/ppp/ccp.o \
	${OBJECTDIR}/lwip/src/netif/ppp/chap-md5.o \
	${OBJECTDIR}/lwip/src/netif/ppp/chap-new.o \
	${OBJECTDIR}/lwip/src/netif/ppp/chap_ms.o \
	${OBJECTDIR}/lwip/src/netif/ppp/demand.o \
	${OBJECTDIR}/lwip/src/netif/ppp/eap.o \
	${OBJECTDIR}/lwip/src/netif/ppp/ecp.o \
	${OBJECTDIR}/lwip/src/netif/ppp/eui64.o \
	${OBJECTDIR}/lwip/src/netif/ppp/fsm.o \
	${OBJECTDIR}/lwip/src/netif/ppp/ipcp.o \
	${OBJECTDIR}/lwip/src/netif/ppp/ipv6cp.o \
	${OBJECTDIR}/lwip/src/netif/ppp/lcp.o \
	${OBJECTDIR}/lwip/src/netif/ppp/magic.o \
	${OBJECTDIR}/lwip/src/netif/ppp/mppe.o \
	${OBJECTDIR}/lwip/src/netif/ppp/multilink.o \
	${OBJECTDIR}/lwip/src/netif/ppp/polarssl/arc4.o \
	${OBJECTDIR}/lwip/src/netif/ppp/polarssl/des.o \
	${OBJECTDIR}/lwip/src/netif/ppp/polarssl/md4.o \
	${OBJECTDIR}/lwip/src/netif/ppp/polarssl/md5.o \
	${OBJECTDIR}/lwip/src/netif/ppp/polarssl/sha1.o \
	${OBJECTDIR}/lwip/src/netif/ppp/ppp.o \
	${OBJECTDIR}/lwip/src/netif/ppp/pppcrypt.o \
	${OBJECTDIR}/lwip/src/netif/ppp/pppoe.o \
	${OBJECTDIR}/lwip/src/netif/ppp/pppol2tp.o \
	${OBJECTDIR}/lwip/src/netif/ppp/pppos.o \
	${OBJECTDIR}/lwip/src/netif/ppp/upap.o \
	${OBJECTDIR}/lwip/src/netif/ppp/utils.o \
	${OBJECTDIR}/lwip/src/netif/ppp/vj.o \
	${OBJECTDIR}/lwip/src/netif/slipif.o \
	${OBJECTDIR}/main/machdep.o \
	${OBJECTDIR}/main/machdev.o \
	${OBJECTDIR}/main/main.o \
	${OBJECTDIR}/main/sys_arch.o \
	${OBJECTDIR}/main/tests.o \
	${OBJECTDIR}/main/trap.o \
	${OBJECTDIR}/mqtt/Clients.o \
	${OBJECTDIR}/mqtt/LinkedList.o \
	${OBJECTDIR}/mqtt/Log.o \
	${OBJECTDIR}/mqtt/MQTTClient.o \
	${OBJECTDIR}/mqtt/MQTTPacket.o \
	${OBJECTDIR}/mqtt/MQTTPacketOut.o \
	${OBJECTDIR}/mqtt/MQTTProtocolClient.o \
	${OBJECTDIR}/mqtt/MQTTProtocolOut.o \
	${OBJECTDIR}/mqtt/Messages.o \
	${OBJECTDIR}/mqtt/SSLSocket.o \
	${OBJECTDIR}/mqtt/Socket.o \
	${OBJECTDIR}/mqtt/SocketBuffer.o \
	${OBJECTDIR}/mqtt/Thread.o \
	${OBJECTDIR}/mqtt/utf-8.o \
	${OBJECTDIR}/sys/fat/diskio.o \
	${OBJECTDIR}/sys/fat/ff.o \
	${OBJECTDIR}/sys/fat/option/syscall.o \
	${OBJECTDIR}/sys/fat/option/unicode.o \
	${OBJECTDIR}/sys/spiffs/spiffs_cache.o \
	${OBJECTDIR}/sys/spiffs/spiffs_check.o \
	${OBJECTDIR}/sys/spiffs/spiffs_gc.o \
	${OBJECTDIR}/sys/spiffs/spiffs_hydrogen.o \
	${OBJECTDIR}/sys/spiffs/spiffs_nucleus.o \
	${OBJECTDIR}/sys/syscalls/__sysctl.o \
	${OBJECTDIR}/sys/syscalls/_exit.o \
	${OBJECTDIR}/sys/syscalls/descrip.o \
	${OBJECTDIR}/sys/syscalls/fs.o \
	${OBJECTDIR}/sys/syscalls/generic.o \
	${OBJECTDIR}/sys/syscalls/getrusage.o \
	${OBJECTDIR}/sys/syscalls/ioctl.o \
	${OBJECTDIR}/sys/syscalls/lseek.o \
	${OBJECTDIR}/sys/syscalls/mkdir.o \
	${OBJECTDIR}/sys/syscalls/mmap.o \
	${OBJECTDIR}/sys/syscalls/mount.o \
	${OBJECTDIR}/sys/syscalls/mutex.o \
	${OBJECTDIR}/sys/syscalls/open.o \
	${OBJECTDIR}/sys/syscalls/ops/fat_ops.o \
	${OBJECTDIR}/sys/syscalls/ops/net_ops.o \
	${OBJECTDIR}/sys/syscalls/ops/spiffs_ops.o \
	${OBJECTDIR}/sys/syscalls/ops/tty_ops.o \
	${OBJECTDIR}/sys/syscalls/prot.o \
	${OBJECTDIR}/sys/syscalls/rename.o \
	${OBJECTDIR}/sys/syscalls/select.o \
	${OBJECTDIR}/sys/syscalls/sigblock.o \
	${OBJECTDIR}/sys/syscalls/sigprocmask.o \
	${OBJECTDIR}/sys/syscalls/stack.o \
	${OBJECTDIR}/sys/syscalls/stat.o \
	${OBJECTDIR}/sys/syscalls/system.o \
	${OBJECTDIR}/sys/syscalls/umask.o \
	${OBJECTDIR}/sys/syscalls/unlink.o \
	${OBJECTDIR}/sys/syscalls/utime.o \
	${OBJECTDIR}/sys/syscalls/utimes.o \
	${OBJECTDIR}/sys/syscalls/wait4.o \
	${OBJECTDIR}/utils/delay.o \
	${OBJECTDIR}/utils/edit.o \
	${OBJECTDIR}/utils/ping.o


# C Compiler Flags
CFLAGS=-Dnational -mips32r2 -EL -mhard-float -fno-short-double -mfp64 -nostdinc -D__PIC32MZ__ -G 0 -Os -fno-builtin -DLUA_COMPAT_MODULE -DLUA_USE_CTYPE -DLUA_C89_NUMBERS -DCLOCKS_PER_SEC=1000 -DHARDMEMTESTS -DHARDSTACKTESTS -DLUA_COMPAT_5_2 -fno-builtin -ffunction-sections -fdata-sections

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=-mdsp -mips32r2 -EL -mfp64 -G 0 -Os

# Link Libraries and Options
LDLIBSOPTIONS=lib/libc/string/bcmp.o lib/libc/string/bcopy.o lib/libc/string/bzero.o lib/libc/string/ffs.o lib/libc/string/index.o lib/libc/string/rindex.o lib/libc/string/strcmp.o lib/libc/string/strlen.o lib/libc/gen/_setjmp.o lib/libc/gen/fabs.o lib/libc/gen/isinf.o lib/libc/gen/ldexp.o lib/libc/gen/modf.o FreeRTOS/port/port_asm.o main/locore.o

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/string/bcmp.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/string/bcopy.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/string/bzero.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/string/ffs.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/string/index.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/string/rindex.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/string/strcmp.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/string/strlen.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/gen/_setjmp.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/gen/fabs.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/gen/isinf.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/gen/ldexp.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: lib/libc/gen/modf.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: FreeRTOS/port/port_asm.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: main/locore.o

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${LINK.c} -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1 ${OBJECTFILES} ${LDLIBSOPTIONS} -mips32r2 -EL -nostdlib -nostartfiles -T ./main/boot.ld -Wl,--oformat=elf32-littlemips -o LuaOS_V1.elf -Wl,-z,max-page-size=4096,-Os -Wl,-Map=LuaOS_V1.map -Wl,--gc-sections

${OBJECTDIR}/FreeRTOS/common/croutine.o: FreeRTOS/common/croutine.c 
	${MKDIR} -p ${OBJECTDIR}/FreeRTOS/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FreeRTOS/common/croutine.o FreeRTOS/common/croutine.c

${OBJECTDIR}/FreeRTOS/common/event_groups.o: FreeRTOS/common/event_groups.c 
	${MKDIR} -p ${OBJECTDIR}/FreeRTOS/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FreeRTOS/common/event_groups.o FreeRTOS/common/event_groups.c

${OBJECTDIR}/FreeRTOS/common/heap_4.o: FreeRTOS/common/heap_4.c 
	${MKDIR} -p ${OBJECTDIR}/FreeRTOS/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FreeRTOS/common/heap_4.o FreeRTOS/common/heap_4.c

${OBJECTDIR}/FreeRTOS/common/list.o: FreeRTOS/common/list.c 
	${MKDIR} -p ${OBJECTDIR}/FreeRTOS/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FreeRTOS/common/list.o FreeRTOS/common/list.c

${OBJECTDIR}/FreeRTOS/common/queue.o: FreeRTOS/common/queue.c 
	${MKDIR} -p ${OBJECTDIR}/FreeRTOS/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FreeRTOS/common/queue.o FreeRTOS/common/queue.c

${OBJECTDIR}/FreeRTOS/common/tasks.o: FreeRTOS/common/tasks.c 
	${MKDIR} -p ${OBJECTDIR}/FreeRTOS/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FreeRTOS/common/tasks.o FreeRTOS/common/tasks.c

${OBJECTDIR}/FreeRTOS/common/timers.o: FreeRTOS/common/timers.c 
	${MKDIR} -p ${OBJECTDIR}/FreeRTOS/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FreeRTOS/common/timers.o FreeRTOS/common/timers.c

${OBJECTDIR}/FreeRTOS/port/port.o: FreeRTOS/port/port.c 
	${MKDIR} -p ${OBJECTDIR}/FreeRTOS/port
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FreeRTOS/port/port.o FreeRTOS/port/port.c

${OBJECTDIR}/FreeRTOS/thread.o: FreeRTOS/thread.c 
	${MKDIR} -p ${OBJECTDIR}/FreeRTOS
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FreeRTOS/thread.o FreeRTOS/thread.c

${OBJECTDIR}/Lua/5.3.1/lapi.o: Lua/5.3.1/lapi.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lapi.o Lua/5.3.1/lapi.c

${OBJECTDIR}/Lua/5.3.1/lauxlib.o: Lua/5.3.1/lauxlib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lauxlib.o Lua/5.3.1/lauxlib.c

${OBJECTDIR}/Lua/5.3.1/lbaselib.o: Lua/5.3.1/lbaselib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lbaselib.o Lua/5.3.1/lbaselib.c

${OBJECTDIR}/Lua/5.3.1/lbitlib.o: Lua/5.3.1/lbitlib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lbitlib.o Lua/5.3.1/lbitlib.c

${OBJECTDIR}/Lua/5.3.1/lcode.o: Lua/5.3.1/lcode.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lcode.o Lua/5.3.1/lcode.c

${OBJECTDIR}/Lua/5.3.1/lcorolib.o: Lua/5.3.1/lcorolib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lcorolib.o Lua/5.3.1/lcorolib.c

${OBJECTDIR}/Lua/5.3.1/lctype.o: Lua/5.3.1/lctype.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lctype.o Lua/5.3.1/lctype.c

${OBJECTDIR}/Lua/5.3.1/ldblib.o: Lua/5.3.1/ldblib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/ldblib.o Lua/5.3.1/ldblib.c

${OBJECTDIR}/Lua/5.3.1/ldebug.o: Lua/5.3.1/ldebug.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/ldebug.o Lua/5.3.1/ldebug.c

${OBJECTDIR}/Lua/5.3.1/ldo.o: Lua/5.3.1/ldo.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/ldo.o Lua/5.3.1/ldo.c

${OBJECTDIR}/Lua/5.3.1/ldump.o: Lua/5.3.1/ldump.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/ldump.o Lua/5.3.1/ldump.c

${OBJECTDIR}/Lua/5.3.1/lfunc.o: Lua/5.3.1/lfunc.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lfunc.o Lua/5.3.1/lfunc.c

${OBJECTDIR}/Lua/5.3.1/lgc.o: Lua/5.3.1/lgc.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lgc.o Lua/5.3.1/lgc.c

${OBJECTDIR}/Lua/5.3.1/linit.o: Lua/5.3.1/linit.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/linit.o Lua/5.3.1/linit.c

${OBJECTDIR}/Lua/5.3.1/liolib.o: Lua/5.3.1/liolib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/liolib.o Lua/5.3.1/liolib.c

${OBJECTDIR}/Lua/5.3.1/llex.o: Lua/5.3.1/llex.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/llex.o Lua/5.3.1/llex.c

${OBJECTDIR}/Lua/5.3.1/lmathlib.o: Lua/5.3.1/lmathlib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lmathlib.o Lua/5.3.1/lmathlib.c

${OBJECTDIR}/Lua/5.3.1/lmem.o: Lua/5.3.1/lmem.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lmem.o Lua/5.3.1/lmem.c

${OBJECTDIR}/Lua/5.3.1/loadlib.o: Lua/5.3.1/loadlib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/loadlib.o Lua/5.3.1/loadlib.c

${OBJECTDIR}/Lua/5.3.1/lobject.o: Lua/5.3.1/lobject.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lobject.o Lua/5.3.1/lobject.c

${OBJECTDIR}/Lua/5.3.1/lopcodes.o: Lua/5.3.1/lopcodes.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lopcodes.o Lua/5.3.1/lopcodes.c

${OBJECTDIR}/Lua/5.3.1/loslib.o: Lua/5.3.1/loslib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/loslib.o Lua/5.3.1/loslib.c

${OBJECTDIR}/Lua/5.3.1/lparser.o: Lua/5.3.1/lparser.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lparser.o Lua/5.3.1/lparser.c

${OBJECTDIR}/Lua/5.3.1/lstate.o: Lua/5.3.1/lstate.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lstate.o Lua/5.3.1/lstate.c

${OBJECTDIR}/Lua/5.3.1/lstring.o: Lua/5.3.1/lstring.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lstring.o Lua/5.3.1/lstring.c

${OBJECTDIR}/Lua/5.3.1/lstrlib.o: Lua/5.3.1/lstrlib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lstrlib.o Lua/5.3.1/lstrlib.c

${OBJECTDIR}/Lua/5.3.1/ltable.o: Lua/5.3.1/ltable.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/ltable.o Lua/5.3.1/ltable.c

${OBJECTDIR}/Lua/5.3.1/ltablib.o: Lua/5.3.1/ltablib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/ltablib.o Lua/5.3.1/ltablib.c

${OBJECTDIR}/Lua/5.3.1/ltm.o: Lua/5.3.1/ltm.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/ltm.o Lua/5.3.1/ltm.c

${OBJECTDIR}/Lua/5.3.1/lua.o: Lua/5.3.1/lua.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lua.o Lua/5.3.1/lua.c

${OBJECTDIR}/Lua/5.3.1/luac.o: Lua/5.3.1/luac.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/luac.o Lua/5.3.1/luac.c

${OBJECTDIR}/Lua/5.3.1/lundump.o: Lua/5.3.1/lundump.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lundump.o Lua/5.3.1/lundump.c

${OBJECTDIR}/Lua/5.3.1/lutf8lib.o: Lua/5.3.1/lutf8lib.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lutf8lib.o Lua/5.3.1/lutf8lib.c

${OBJECTDIR}/Lua/5.3.1/lvm.o: Lua/5.3.1/lvm.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lvm.o Lua/5.3.1/lvm.c

${OBJECTDIR}/Lua/5.3.1/lzio.o: Lua/5.3.1/lzio.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/5.3.1
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/5.3.1/lzio.o Lua/5.3.1/lzio.c

${OBJECTDIR}/Lua/elua/src/common_tmr.o: Lua/elua/src/common_tmr.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/elua/src
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/elua/src/common_tmr.o Lua/elua/src/common_tmr.c

${OBJECTDIR}/Lua/elua/src/linenoise.o: Lua/elua/src/linenoise.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/elua/src
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/elua/src/linenoise.o Lua/elua/src/linenoise.c

${OBJECTDIR}/Lua/elua/src/platform/pic32mz/platform.o: Lua/elua/src/platform/pic32mz/platform.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/elua/src/platform/pic32mz
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/elua/src/platform/pic32mz/platform.o Lua/elua/src/platform/pic32mz/platform.c

${OBJECTDIR}/Lua/modules/adc.o: Lua/modules/adc.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/adc.o Lua/modules/adc.c

${OBJECTDIR}/Lua/modules/can.o: Lua/modules/can.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/can.o Lua/modules/can.c

${OBJECTDIR}/Lua/modules/cpu.o: Lua/modules/cpu.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/cpu.o Lua/modules/cpu.c

${OBJECTDIR}/Lua/modules/gps.o: Lua/modules/gps.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/gps.o Lua/modules/gps.c

${OBJECTDIR}/Lua/modules/mqtt.o: Lua/modules/mqtt.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/mqtt.o Lua/modules/mqtt.c

${OBJECTDIR}/Lua/modules/net.o: Lua/modules/net.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/net.o Lua/modules/net.c

${OBJECTDIR}/Lua/modules/pd.o: Lua/modules/pd.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/pd.o Lua/modules/pd.c

${OBJECTDIR}/Lua/modules/pio.o: Lua/modules/pio.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/pio.o Lua/modules/pio.c

${OBJECTDIR}/Lua/modules/pwm.o: Lua/modules/pwm.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/pwm.o Lua/modules/pwm.c

${OBJECTDIR}/Lua/modules/screen/bitmap.o: Lua/modules/screen/bitmap.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules/screen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/screen/bitmap.o Lua/modules/screen/bitmap.c

${OBJECTDIR}/Lua/modules/screen/endian.o: Lua/modules/screen/endian.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules/screen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/screen/endian.o Lua/modules/screen/endian.c

${OBJECTDIR}/Lua/modules/screen/screen.o: Lua/modules/screen/screen.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules/screen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/screen/screen.o Lua/modules/screen/screen.c

${OBJECTDIR}/Lua/modules/spi.o: Lua/modules/spi.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/spi.o Lua/modules/spi.c

${OBJECTDIR}/Lua/modules/tmr.o: Lua/modules/tmr.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/tmr.o Lua/modules/tmr.c

${OBJECTDIR}/Lua/modules/uart.o: Lua/modules/uart.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/modules
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/modules/uart.o Lua/modules/uart.c

${OBJECTDIR}/Lua/platform/adc.o: Lua/platform/adc.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/platform
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/platform/adc.o Lua/platform/adc.c

${OBJECTDIR}/Lua/platform/can.o: Lua/platform/can.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/platform
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/platform/can.o Lua/platform/can.c

${OBJECTDIR}/Lua/platform/cpu.o: Lua/platform/cpu.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/platform
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/platform/cpu.o Lua/platform/cpu.c

${OBJECTDIR}/Lua/platform/gps.o: Lua/platform/gps.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/platform
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/platform/gps.o Lua/platform/gps.c

${OBJECTDIR}/Lua/platform/net.o: Lua/platform/net.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/platform
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/platform/net.o Lua/platform/net.c

${OBJECTDIR}/Lua/platform/pio.o: Lua/platform/pio.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/platform
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/platform/pio.o Lua/platform/pio.c

${OBJECTDIR}/Lua/platform/pwm.o: Lua/platform/pwm.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/platform
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/platform/pwm.o Lua/platform/pwm.c

${OBJECTDIR}/Lua/platform/spi.o: Lua/platform/spi.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/platform
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/platform/spi.o Lua/platform/spi.c

${OBJECTDIR}/Lua/platform/uart.o: Lua/platform/uart.c 
	${MKDIR} -p ${OBJECTDIR}/Lua/platform
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Lua/platform/uart.o Lua/platform/uart.c

${OBJECTDIR}/drivers/adc/adc.o: drivers/adc/adc.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/adc
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/adc/adc.o drivers/adc/adc.c

${OBJECTDIR}/drivers/can/can.o: drivers/can/can.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/can
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/can/can.o drivers/can/can.c

${OBJECTDIR}/drivers/cfi/cfi.o: drivers/cfi/cfi.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/cfi
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/cfi/cfi.o drivers/cfi/cfi.c

${OBJECTDIR}/drivers/clock/clock.o: drivers/clock/clock.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/clock
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/clock/clock.o drivers/clock/clock.c

${OBJECTDIR}/drivers/console/console.o: drivers/console/console.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/console
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/console/console.o drivers/console/console.c

${OBJECTDIR}/drivers/cpu/cpu.o: drivers/cpu/cpu.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/cpu
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/cpu/cpu.o drivers/cpu/cpu.c

${OBJECTDIR}/drivers/display/ST7735S/ST7735S.o: drivers/display/ST7735S/ST7735S.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/display/ST7735S
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/display/ST7735S/ST7735S.o drivers/display/ST7735S/ST7735S.c

${OBJECTDIR}/drivers/display/display.o: drivers/display/display.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/display
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/display/display.o drivers/display/display.c

${OBJECTDIR}/drivers/display/font.o: drivers/display/font.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/display
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/display/font.o drivers/display/font.c

${OBJECTDIR}/drivers/dma/dma.o: drivers/dma/dma.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/dma
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/dma/dma.o drivers/dma/dma.c

${OBJECTDIR}/drivers/gpio/gpio.o: drivers/gpio/gpio.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/gpio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/gpio/gpio.o drivers/gpio/gpio.c

${OBJECTDIR}/drivers/gprs/gprs.o: drivers/gprs/gprs.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/gprs
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/gprs/gprs.o drivers/gprs/gprs.c

${OBJECTDIR}/drivers/gps/gps.o: drivers/gps/gps.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/gps
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/gps/gps.o drivers/gps/gps.c

${OBJECTDIR}/drivers/gps/nmea0183.o: drivers/gps/nmea0183.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/gps
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/gps/nmea0183.o drivers/gps/nmea0183.c

${OBJECTDIR}/drivers/net/ENC424J600/ENC424J600.o: drivers/net/ENC424J600/ENC424J600.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/net/ENC424J600
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/net/ENC424J600/ENC424J600.o drivers/net/ENC424J600/ENC424J600.c

${OBJECTDIR}/drivers/net/ethernetif.o: drivers/net/ethernetif.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/net
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/net/ethernetif.o drivers/net/ethernetif.c

${OBJECTDIR}/drivers/net/phy/phy.o: drivers/net/phy/phy.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/net/phy
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/net/phy/phy.o drivers/net/phy/phy.c

${OBJECTDIR}/drivers/network/network.o: drivers/network/network.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/network
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/network/network.o drivers/network/network.c

${OBJECTDIR}/drivers/pwm/pwm.o: drivers/pwm/pwm.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/pwm
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/pwm/pwm.o drivers/pwm/pwm.c

${OBJECTDIR}/drivers/sd/sd.o: drivers/sd/sd.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/sd
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/sd/sd.o drivers/sd/sd.c

${OBJECTDIR}/drivers/sim908/sim908.o: drivers/sim908/sim908.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/sim908
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/sim908/sim908.o drivers/sim908/sim908.c

${OBJECTDIR}/drivers/spi/spi.o: drivers/spi/spi.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/spi
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/spi/spi.o drivers/spi/spi.c

${OBJECTDIR}/drivers/uart/uart.o: drivers/uart/uart.c 
	${MKDIR} -p ${OBJECTDIR}/drivers/uart
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/drivers/uart/uart.o drivers/uart/uart.c

${OBJECTDIR}/lib/libc/gen/assert.o: lib/libc/gen/assert.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/assert.o lib/libc/gen/assert.c

${OBJECTDIR}/lib/libc/gen/clock.o: lib/libc/gen/clock.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/clock.o lib/libc/gen/clock.c

${OBJECTDIR}/lib/libc/gen/closedir.o: lib/libc/gen/closedir.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/closedir.o lib/libc/gen/closedir.c

${OBJECTDIR}/lib/libc/gen/crypt.o: lib/libc/gen/crypt.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/crypt.o lib/libc/gen/crypt.c

${OBJECTDIR}/lib/libc/gen/ctermid.o: lib/libc/gen/ctermid.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/ctermid.o lib/libc/gen/ctermid.c

${OBJECTDIR}/lib/libc/gen/ctime.o: lib/libc/gen/ctime.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/ctime.o lib/libc/gen/ctime.c

${OBJECTDIR}/lib/libc/gen/difftime.o: lib/libc/gen/difftime.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/difftime.o lib/libc/gen/difftime.c

${OBJECTDIR}/lib/libc/gen/disklabel.o: lib/libc/gen/disklabel.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/disklabel.o lib/libc/gen/disklabel.c

${OBJECTDIR}/lib/libc/gen/err.o: lib/libc/gen/err.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/err.o lib/libc/gen/err.c

${OBJECTDIR}/lib/libc/gen/errlst.o: lib/libc/gen/errlst.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/errlst.o lib/libc/gen/errlst.c

${OBJECTDIR}/lib/libc/gen/exec.o: lib/libc/gen/exec.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/exec.o lib/libc/gen/exec.c

${OBJECTDIR}/lib/libc/gen/fnmatch.o: lib/libc/gen/fnmatch.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/fnmatch.o lib/libc/gen/fnmatch.c

${OBJECTDIR}/lib/libc/gen/frexp.o: lib/libc/gen/frexp.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/frexp.o lib/libc/gen/frexp.c

${OBJECTDIR}/lib/libc/gen/fstab.o: lib/libc/gen/fstab.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/fstab.o lib/libc/gen/fstab.c

${OBJECTDIR}/lib/libc/gen/fts.o: lib/libc/gen/fts.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/fts.o lib/libc/gen/fts.c

${OBJECTDIR}/lib/libc/gen/getbsize.o: lib/libc/gen/getbsize.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getbsize.o lib/libc/gen/getbsize.c

${OBJECTDIR}/lib/libc/gen/getcwd.o: lib/libc/gen/getcwd.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getcwd.o lib/libc/gen/getcwd.c

${OBJECTDIR}/lib/libc/gen/getgrent.o: lib/libc/gen/getgrent.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getgrent.o lib/libc/gen/getgrent.c

${OBJECTDIR}/lib/libc/gen/getgrouplist.o: lib/libc/gen/getgrouplist.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getgrouplist.o lib/libc/gen/getgrouplist.c

${OBJECTDIR}/lib/libc/gen/gethostname.o: lib/libc/gen/gethostname.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/gethostname.o lib/libc/gen/gethostname.c

${OBJECTDIR}/lib/libc/gen/getloadavg.o: lib/libc/gen/getloadavg.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getloadavg.o lib/libc/gen/getloadavg.c

${OBJECTDIR}/lib/libc/gen/getmntinfo.o: lib/libc/gen/getmntinfo.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getmntinfo.o lib/libc/gen/getmntinfo.c

${OBJECTDIR}/lib/libc/gen/getnetgrent.o: lib/libc/gen/getnetgrent.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getnetgrent.o lib/libc/gen/getnetgrent.c

${OBJECTDIR}/lib/libc/gen/getpagesize.o: lib/libc/gen/getpagesize.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getpagesize.o lib/libc/gen/getpagesize.c

${OBJECTDIR}/lib/libc/gen/getpass.o: lib/libc/gen/getpass.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getpass.o lib/libc/gen/getpass.c

${OBJECTDIR}/lib/libc/gen/getttyent.o: lib/libc/gen/getttyent.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getttyent.o lib/libc/gen/getttyent.c

${OBJECTDIR}/lib/libc/gen/getusershell.o: lib/libc/gen/getusershell.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getusershell.o lib/libc/gen/getusershell.c

${OBJECTDIR}/lib/libc/gen/getvfsbyname.o: lib/libc/gen/getvfsbyname.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/getvfsbyname.o lib/libc/gen/getvfsbyname.c

${OBJECTDIR}/lib/libc/gen/isatty.o: lib/libc/gen/isatty.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/isatty.o lib/libc/gen/isatty.c

${OBJECTDIR}/lib/libc/gen/opendir.o: lib/libc/gen/opendir.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/opendir.o lib/libc/gen/opendir.c

${OBJECTDIR}/lib/libc/gen/popen.o: lib/libc/gen/popen.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/popen.o lib/libc/gen/popen.c

${OBJECTDIR}/lib/libc/gen/psignal.o: lib/libc/gen/psignal.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/psignal.o lib/libc/gen/psignal.c

${OBJECTDIR}/lib/libc/gen/readdir.o: lib/libc/gen/readdir.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/readdir.o lib/libc/gen/readdir.c

${OBJECTDIR}/lib/libc/gen/scandir.o: lib/libc/gen/scandir.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/scandir.o lib/libc/gen/scandir.c

${OBJECTDIR}/lib/libc/gen/sethostname.o: lib/libc/gen/sethostname.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/sethostname.o lib/libc/gen/sethostname.c

${OBJECTDIR}/lib/libc/gen/setjmperr.o: lib/libc/gen/setjmperr.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/setjmperr.o lib/libc/gen/setjmperr.c

${OBJECTDIR}/lib/libc/gen/setmode.o: lib/libc/gen/setmode.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/setmode.o lib/libc/gen/setmode.c

${OBJECTDIR}/lib/libc/gen/siglist.o: lib/libc/gen/siglist.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/siglist.o lib/libc/gen/siglist.c

${OBJECTDIR}/lib/libc/gen/signal.o: lib/libc/gen/signal.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/signal.o lib/libc/gen/signal.c

${OBJECTDIR}/lib/libc/gen/sigsetops.o: lib/libc/gen/sigsetops.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/sigsetops.o lib/libc/gen/sigsetops.c

${OBJECTDIR}/lib/libc/gen/sleep.o: lib/libc/gen/sleep.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/sleep.o lib/libc/gen/sleep.c

${OBJECTDIR}/lib/libc/gen/sysctl.o: lib/libc/gen/sysctl.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/sysctl.o lib/libc/gen/sysctl.c

${OBJECTDIR}/lib/libc/gen/syslog.o: lib/libc/gen/syslog.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/syslog.o lib/libc/gen/syslog.c

${OBJECTDIR}/lib/libc/gen/telldir.o: lib/libc/gen/telldir.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/telldir.o lib/libc/gen/telldir.c

${OBJECTDIR}/lib/libc/gen/termios.o: lib/libc/gen/termios.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/termios.o lib/libc/gen/termios.c

${OBJECTDIR}/lib/libc/gen/time.o: lib/libc/gen/time.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/time.o lib/libc/gen/time.c

${OBJECTDIR}/lib/libc/gen/times.o: lib/libc/gen/times.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/times.o lib/libc/gen/times.c

${OBJECTDIR}/lib/libc/gen/timezone.o: lib/libc/gen/timezone.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/timezone.o lib/libc/gen/timezone.c

${OBJECTDIR}/lib/libc/gen/ualarm.o: lib/libc/gen/ualarm.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/ualarm.o lib/libc/gen/ualarm.c

${OBJECTDIR}/lib/libc/gen/uname.o: lib/libc/gen/uname.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/uname.o lib/libc/gen/uname.c

${OBJECTDIR}/lib/libc/gen/unvis.o: lib/libc/gen/unvis.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/unvis.o lib/libc/gen/unvis.c

${OBJECTDIR}/lib/libc/gen/usleep.o: lib/libc/gen/usleep.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/usleep.o lib/libc/gen/usleep.c

${OBJECTDIR}/lib/libc/gen/utime.o: lib/libc/gen/utime.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/utime.o lib/libc/gen/utime.c

${OBJECTDIR}/lib/libc/gen/valloc.o: lib/libc/gen/valloc.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/valloc.o lib/libc/gen/valloc.c

${OBJECTDIR}/lib/libc/gen/vis.o: lib/libc/gen/vis.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/vis.o lib/libc/gen/vis.c

${OBJECTDIR}/lib/libc/gen/wait.o: lib/libc/gen/wait.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/wait.o lib/libc/gen/wait.c

${OBJECTDIR}/lib/libc/gen/wait3.o: lib/libc/gen/wait3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/wait3.o lib/libc/gen/wait3.c

${OBJECTDIR}/lib/libc/gen/waitpid.o: lib/libc/gen/waitpid.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/gen
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/gen/waitpid.o lib/libc/gen/waitpid.c

${OBJECTDIR}/lib/libc/locale/ansi.o: lib/libc/locale/ansi.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/ansi.o lib/libc/locale/ansi.c

${OBJECTDIR}/lib/libc/locale/ctype.o: lib/libc/locale/ctype.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/ctype.o lib/libc/locale/ctype.c

${OBJECTDIR}/lib/libc/locale/euc.o: lib/libc/locale/euc.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/euc.o lib/libc/locale/euc.c

${OBJECTDIR}/lib/libc/locale/frune.o: lib/libc/locale/frune.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/frune.o lib/libc/locale/frune.c

${OBJECTDIR}/lib/libc/locale/isctype.o: lib/libc/locale/isctype.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/isctype.o lib/libc/locale/isctype.c

${OBJECTDIR}/lib/libc/locale/lconv.o: lib/libc/locale/lconv.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/lconv.o lib/libc/locale/lconv.c

${OBJECTDIR}/lib/libc/locale/localeconv.o: lib/libc/locale/localeconv.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/localeconv.o lib/libc/locale/localeconv.c

${OBJECTDIR}/lib/libc/locale/mbrune.o: lib/libc/locale/mbrune.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/mbrune.o lib/libc/locale/mbrune.c

${OBJECTDIR}/lib/libc/locale/none.o: lib/libc/locale/none.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/none.o lib/libc/locale/none.c

${OBJECTDIR}/lib/libc/locale/rune.o: lib/libc/locale/rune.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/rune.o lib/libc/locale/rune.c

${OBJECTDIR}/lib/libc/locale/setlocale.o: lib/libc/locale/setlocale.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/setlocale.o lib/libc/locale/setlocale.c

${OBJECTDIR}/lib/libc/locale/table.o: lib/libc/locale/table.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/table.o lib/libc/locale/table.c

${OBJECTDIR}/lib/libc/locale/utf2.o: lib/libc/locale/utf2.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/locale
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/locale/utf2.o lib/libc/locale/utf2.c

${OBJECTDIR}/lib/libc/quad/adddi3.o: lib/libc/quad/adddi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/adddi3.o lib/libc/quad/adddi3.c

${OBJECTDIR}/lib/libc/quad/anddi3.o: lib/libc/quad/anddi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/anddi3.o lib/libc/quad/anddi3.c

${OBJECTDIR}/lib/libc/quad/ashldi3.o: lib/libc/quad/ashldi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/ashldi3.o lib/libc/quad/ashldi3.c

${OBJECTDIR}/lib/libc/quad/ashrdi3.o: lib/libc/quad/ashrdi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/ashrdi3.o lib/libc/quad/ashrdi3.c

${OBJECTDIR}/lib/libc/quad/cmpdi2.o: lib/libc/quad/cmpdi2.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/cmpdi2.o lib/libc/quad/cmpdi2.c

${OBJECTDIR}/lib/libc/quad/divdi3.o: lib/libc/quad/divdi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/divdi3.o lib/libc/quad/divdi3.c

${OBJECTDIR}/lib/libc/quad/fixdfdi.o: lib/libc/quad/fixdfdi.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/fixdfdi.o lib/libc/quad/fixdfdi.c

${OBJECTDIR}/lib/libc/quad/fixsfdi.o: lib/libc/quad/fixsfdi.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/fixsfdi.o lib/libc/quad/fixsfdi.c

${OBJECTDIR}/lib/libc/quad/fixunsdfdi.o: lib/libc/quad/fixunsdfdi.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/fixunsdfdi.o lib/libc/quad/fixunsdfdi.c

${OBJECTDIR}/lib/libc/quad/fixunssfdi.o: lib/libc/quad/fixunssfdi.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/fixunssfdi.o lib/libc/quad/fixunssfdi.c

${OBJECTDIR}/lib/libc/quad/floatdidf.o: lib/libc/quad/floatdidf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/floatdidf.o lib/libc/quad/floatdidf.c

${OBJECTDIR}/lib/libc/quad/floatdisf.o: lib/libc/quad/floatdisf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/floatdisf.o lib/libc/quad/floatdisf.c

${OBJECTDIR}/lib/libc/quad/floatunsdidf.o: lib/libc/quad/floatunsdidf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/floatunsdidf.o lib/libc/quad/floatunsdidf.c

${OBJECTDIR}/lib/libc/quad/iordi3.o: lib/libc/quad/iordi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/iordi3.o lib/libc/quad/iordi3.c

${OBJECTDIR}/lib/libc/quad/lshldi3.o: lib/libc/quad/lshldi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/lshldi3.o lib/libc/quad/lshldi3.c

${OBJECTDIR}/lib/libc/quad/lshrdi3.o: lib/libc/quad/lshrdi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/lshrdi3.o lib/libc/quad/lshrdi3.c

${OBJECTDIR}/lib/libc/quad/moddi3.o: lib/libc/quad/moddi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/moddi3.o lib/libc/quad/moddi3.c

${OBJECTDIR}/lib/libc/quad/muldi3.o: lib/libc/quad/muldi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/muldi3.o lib/libc/quad/muldi3.c

${OBJECTDIR}/lib/libc/quad/negdi2.o: lib/libc/quad/negdi2.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/negdi2.o lib/libc/quad/negdi2.c

${OBJECTDIR}/lib/libc/quad/notdi2.o: lib/libc/quad/notdi2.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/notdi2.o lib/libc/quad/notdi2.c

${OBJECTDIR}/lib/libc/quad/qdivrem.o: lib/libc/quad/qdivrem.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/qdivrem.o lib/libc/quad/qdivrem.c

${OBJECTDIR}/lib/libc/quad/subdi3.o: lib/libc/quad/subdi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/subdi3.o lib/libc/quad/subdi3.c

${OBJECTDIR}/lib/libc/quad/ucmpdi2.o: lib/libc/quad/ucmpdi2.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/ucmpdi2.o lib/libc/quad/ucmpdi2.c

${OBJECTDIR}/lib/libc/quad/udivdi3.o: lib/libc/quad/udivdi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/udivdi3.o lib/libc/quad/udivdi3.c

${OBJECTDIR}/lib/libc/quad/umoddi3.o: lib/libc/quad/umoddi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/umoddi3.o lib/libc/quad/umoddi3.c

${OBJECTDIR}/lib/libc/quad/xordi3.o: lib/libc/quad/xordi3.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/quad
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/quad/xordi3.o lib/libc/quad/xordi3.c

${OBJECTDIR}/lib/libc/stdio/clrerr.o: lib/libc/stdio/clrerr.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/clrerr.o lib/libc/stdio/clrerr.c

${OBJECTDIR}/lib/libc/stdio/fclose.o: lib/libc/stdio/fclose.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fclose.o lib/libc/stdio/fclose.c

${OBJECTDIR}/lib/libc/stdio/fdopen.o: lib/libc/stdio/fdopen.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fdopen.o lib/libc/stdio/fdopen.c

${OBJECTDIR}/lib/libc/stdio/feof.o: lib/libc/stdio/feof.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/feof.o lib/libc/stdio/feof.c

${OBJECTDIR}/lib/libc/stdio/ferror.o: lib/libc/stdio/ferror.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/ferror.o lib/libc/stdio/ferror.c

${OBJECTDIR}/lib/libc/stdio/fflush.o: lib/libc/stdio/fflush.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fflush.o lib/libc/stdio/fflush.c

${OBJECTDIR}/lib/libc/stdio/fgetc.o: lib/libc/stdio/fgetc.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fgetc.o lib/libc/stdio/fgetc.c

${OBJECTDIR}/lib/libc/stdio/fgetln.o: lib/libc/stdio/fgetln.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fgetln.o lib/libc/stdio/fgetln.c

${OBJECTDIR}/lib/libc/stdio/fgetpos.o: lib/libc/stdio/fgetpos.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fgetpos.o lib/libc/stdio/fgetpos.c

${OBJECTDIR}/lib/libc/stdio/fgets.o: lib/libc/stdio/fgets.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fgets.o lib/libc/stdio/fgets.c

${OBJECTDIR}/lib/libc/stdio/fileno.o: lib/libc/stdio/fileno.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fileno.o lib/libc/stdio/fileno.c

${OBJECTDIR}/lib/libc/stdio/findfp.o: lib/libc/stdio/findfp.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/findfp.o lib/libc/stdio/findfp.c

${OBJECTDIR}/lib/libc/stdio/flags.o: lib/libc/stdio/flags.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/flags.o lib/libc/stdio/flags.c

${OBJECTDIR}/lib/libc/stdio/fopen.o: lib/libc/stdio/fopen.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fopen.o lib/libc/stdio/fopen.c

${OBJECTDIR}/lib/libc/stdio/fprintf.o: lib/libc/stdio/fprintf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fprintf.o lib/libc/stdio/fprintf.c

${OBJECTDIR}/lib/libc/stdio/fpurge.o: lib/libc/stdio/fpurge.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fpurge.o lib/libc/stdio/fpurge.c

${OBJECTDIR}/lib/libc/stdio/fputc.o: lib/libc/stdio/fputc.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fputc.o lib/libc/stdio/fputc.c

${OBJECTDIR}/lib/libc/stdio/fputs.o: lib/libc/stdio/fputs.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fputs.o lib/libc/stdio/fputs.c

${OBJECTDIR}/lib/libc/stdio/fread.o: lib/libc/stdio/fread.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fread.o lib/libc/stdio/fread.c

${OBJECTDIR}/lib/libc/stdio/freopen.o: lib/libc/stdio/freopen.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/freopen.o lib/libc/stdio/freopen.c

${OBJECTDIR}/lib/libc/stdio/fscanf.o: lib/libc/stdio/fscanf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fscanf.o lib/libc/stdio/fscanf.c

${OBJECTDIR}/lib/libc/stdio/fseek.o: lib/libc/stdio/fseek.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fseek.o lib/libc/stdio/fseek.c

${OBJECTDIR}/lib/libc/stdio/fsetpos.o: lib/libc/stdio/fsetpos.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fsetpos.o lib/libc/stdio/fsetpos.c

${OBJECTDIR}/lib/libc/stdio/ftell.o: lib/libc/stdio/ftell.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/ftell.o lib/libc/stdio/ftell.c

${OBJECTDIR}/lib/libc/stdio/funopen.o: lib/libc/stdio/funopen.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/funopen.o lib/libc/stdio/funopen.c

${OBJECTDIR}/lib/libc/stdio/fvwrite.o: lib/libc/stdio/fvwrite.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fvwrite.o lib/libc/stdio/fvwrite.c

${OBJECTDIR}/lib/libc/stdio/fwalk.o: lib/libc/stdio/fwalk.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fwalk.o lib/libc/stdio/fwalk.c

${OBJECTDIR}/lib/libc/stdio/fwrite.o: lib/libc/stdio/fwrite.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/fwrite.o lib/libc/stdio/fwrite.c

${OBJECTDIR}/lib/libc/stdio/getc.o: lib/libc/stdio/getc.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/getc.o lib/libc/stdio/getc.c

${OBJECTDIR}/lib/libc/stdio/getchar.o: lib/libc/stdio/getchar.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/getchar.o lib/libc/stdio/getchar.c

${OBJECTDIR}/lib/libc/stdio/gets.o: lib/libc/stdio/gets.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/gets.o lib/libc/stdio/gets.c

${OBJECTDIR}/lib/libc/stdio/getw.o: lib/libc/stdio/getw.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/getw.o lib/libc/stdio/getw.c

${OBJECTDIR}/lib/libc/stdio/makebuf.o: lib/libc/stdio/makebuf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/makebuf.o lib/libc/stdio/makebuf.c

${OBJECTDIR}/lib/libc/stdio/mktemp.o: lib/libc/stdio/mktemp.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/mktemp.o lib/libc/stdio/mktemp.c

${OBJECTDIR}/lib/libc/stdio/perror.o: lib/libc/stdio/perror.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/perror.o lib/libc/stdio/perror.c

${OBJECTDIR}/lib/libc/stdio/printf.o: lib/libc/stdio/printf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/printf.o lib/libc/stdio/printf.c

${OBJECTDIR}/lib/libc/stdio/putc.o: lib/libc/stdio/putc.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/putc.o lib/libc/stdio/putc.c

${OBJECTDIR}/lib/libc/stdio/putchar.o: lib/libc/stdio/putchar.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/putchar.o lib/libc/stdio/putchar.c

${OBJECTDIR}/lib/libc/stdio/puts.o: lib/libc/stdio/puts.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/puts.o lib/libc/stdio/puts.c

${OBJECTDIR}/lib/libc/stdio/putw.o: lib/libc/stdio/putw.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/putw.o lib/libc/stdio/putw.c

${OBJECTDIR}/lib/libc/stdio/refill.o: lib/libc/stdio/refill.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/refill.o lib/libc/stdio/refill.c

${OBJECTDIR}/lib/libc/stdio/remove.o: lib/libc/stdio/remove.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/remove.o lib/libc/stdio/remove.c

${OBJECTDIR}/lib/libc/stdio/rewind.o: lib/libc/stdio/rewind.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/rewind.o lib/libc/stdio/rewind.c

${OBJECTDIR}/lib/libc/stdio/rget.o: lib/libc/stdio/rget.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/rget.o lib/libc/stdio/rget.c

${OBJECTDIR}/lib/libc/stdio/scanf.o: lib/libc/stdio/scanf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/scanf.o lib/libc/stdio/scanf.c

${OBJECTDIR}/lib/libc/stdio/setbuf.o: lib/libc/stdio/setbuf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/setbuf.o lib/libc/stdio/setbuf.c

${OBJECTDIR}/lib/libc/stdio/setbuffer.o: lib/libc/stdio/setbuffer.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/setbuffer.o lib/libc/stdio/setbuffer.c

${OBJECTDIR}/lib/libc/stdio/setvbuf.o: lib/libc/stdio/setvbuf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/setvbuf.o lib/libc/stdio/setvbuf.c

${OBJECTDIR}/lib/libc/stdio/snprintf.o: lib/libc/stdio/snprintf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/snprintf.o lib/libc/stdio/snprintf.c

${OBJECTDIR}/lib/libc/stdio/sprintf.o: lib/libc/stdio/sprintf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/sprintf.o lib/libc/stdio/sprintf.c

${OBJECTDIR}/lib/libc/stdio/sscanf.o: lib/libc/stdio/sscanf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/sscanf.o lib/libc/stdio/sscanf.c

${OBJECTDIR}/lib/libc/stdio/stdio.o: lib/libc/stdio/stdio.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/stdio.o lib/libc/stdio/stdio.c

${OBJECTDIR}/lib/libc/stdio/tempnam.o: lib/libc/stdio/tempnam.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/tempnam.o lib/libc/stdio/tempnam.c

${OBJECTDIR}/lib/libc/stdio/tmpfile.o: lib/libc/stdio/tmpfile.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/tmpfile.o lib/libc/stdio/tmpfile.c

${OBJECTDIR}/lib/libc/stdio/tmpnam.o: lib/libc/stdio/tmpnam.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/tmpnam.o lib/libc/stdio/tmpnam.c

${OBJECTDIR}/lib/libc/stdio/ungetc.o: lib/libc/stdio/ungetc.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/ungetc.o lib/libc/stdio/ungetc.c

${OBJECTDIR}/lib/libc/stdio/vfprintf.o: lib/libc/stdio/vfprintf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/vfprintf.o lib/libc/stdio/vfprintf.c

${OBJECTDIR}/lib/libc/stdio/vfscanf.o: lib/libc/stdio/vfscanf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/vfscanf.o lib/libc/stdio/vfscanf.c

${OBJECTDIR}/lib/libc/stdio/vprintf.o: lib/libc/stdio/vprintf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/vprintf.o lib/libc/stdio/vprintf.c

${OBJECTDIR}/lib/libc/stdio/vscanf.o: lib/libc/stdio/vscanf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/vscanf.o lib/libc/stdio/vscanf.c

${OBJECTDIR}/lib/libc/stdio/vsnprintf.o: lib/libc/stdio/vsnprintf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/vsnprintf.o lib/libc/stdio/vsnprintf.c

${OBJECTDIR}/lib/libc/stdio/vsprintf.o: lib/libc/stdio/vsprintf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/vsprintf.o lib/libc/stdio/vsprintf.c

${OBJECTDIR}/lib/libc/stdio/vsscanf.o: lib/libc/stdio/vsscanf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/vsscanf.o lib/libc/stdio/vsscanf.c

${OBJECTDIR}/lib/libc/stdio/wbuf.o: lib/libc/stdio/wbuf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/wbuf.o lib/libc/stdio/wbuf.c

${OBJECTDIR}/lib/libc/stdio/wsetup.o: lib/libc/stdio/wsetup.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdio
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdio/wsetup.o lib/libc/stdio/wsetup.c

${OBJECTDIR}/lib/libc/stdlib/abort.o: lib/libc/stdlib/abort.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/abort.o lib/libc/stdlib/abort.c

${OBJECTDIR}/lib/libc/stdlib/abs.o: lib/libc/stdlib/abs.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/abs.o lib/libc/stdlib/abs.c

${OBJECTDIR}/lib/libc/stdlib/atexit.o: lib/libc/stdlib/atexit.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/atexit.o lib/libc/stdlib/atexit.c

${OBJECTDIR}/lib/libc/stdlib/atof.o: lib/libc/stdlib/atof.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/atof.o lib/libc/stdlib/atof.c

${OBJECTDIR}/lib/libc/stdlib/atoi.o: lib/libc/stdlib/atoi.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/atoi.o lib/libc/stdlib/atoi.c

${OBJECTDIR}/lib/libc/stdlib/atol.o: lib/libc/stdlib/atol.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/atol.o lib/libc/stdlib/atol.c

${OBJECTDIR}/lib/libc/stdlib/bsearch.o: lib/libc/stdlib/bsearch.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/bsearch.o lib/libc/stdlib/bsearch.c

${OBJECTDIR}/lib/libc/stdlib/calloc.o: lib/libc/stdlib/calloc.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/calloc.o lib/libc/stdlib/calloc.c

${OBJECTDIR}/lib/libc/stdlib/div.o: lib/libc/stdlib/div.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/div.o lib/libc/stdlib/div.c

${OBJECTDIR}/lib/libc/stdlib/exit.o: lib/libc/stdlib/exit.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/exit.o lib/libc/stdlib/exit.c

${OBJECTDIR}/lib/libc/stdlib/getenv.o: lib/libc/stdlib/getenv.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/getenv.o lib/libc/stdlib/getenv.c

${OBJECTDIR}/lib/libc/stdlib/getopt.o: lib/libc/stdlib/getopt.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/getopt.o lib/libc/stdlib/getopt.c

${OBJECTDIR}/lib/libc/stdlib/getsubopt.o: lib/libc/stdlib/getsubopt.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/getsubopt.o lib/libc/stdlib/getsubopt.c

${OBJECTDIR}/lib/libc/stdlib/heapsort.o: lib/libc/stdlib/heapsort.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/heapsort.o lib/libc/stdlib/heapsort.c

${OBJECTDIR}/lib/libc/stdlib/labs.o: lib/libc/stdlib/labs.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/labs.o lib/libc/stdlib/labs.c

${OBJECTDIR}/lib/libc/stdlib/ldiv.o: lib/libc/stdlib/ldiv.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/ldiv.o lib/libc/stdlib/ldiv.c

${OBJECTDIR}/lib/libc/stdlib/malloc.o: lib/libc/stdlib/malloc.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/malloc.o lib/libc/stdlib/malloc.c

${OBJECTDIR}/lib/libc/stdlib/merge.o: lib/libc/stdlib/merge.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/merge.o lib/libc/stdlib/merge.c

${OBJECTDIR}/lib/libc/stdlib/putenv.o: lib/libc/stdlib/putenv.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/putenv.o lib/libc/stdlib/putenv.c

${OBJECTDIR}/lib/libc/stdlib/qsort.o: lib/libc/stdlib/qsort.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/qsort.o lib/libc/stdlib/qsort.c

${OBJECTDIR}/lib/libc/stdlib/radixsort.o: lib/libc/stdlib/radixsort.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/radixsort.o lib/libc/stdlib/radixsort.c

${OBJECTDIR}/lib/libc/stdlib/rand.o: lib/libc/stdlib/rand.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/rand.o lib/libc/stdlib/rand.c

${OBJECTDIR}/lib/libc/stdlib/random.o: lib/libc/stdlib/random.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/random.o lib/libc/stdlib/random.c

${OBJECTDIR}/lib/libc/stdlib/setenv.o: lib/libc/stdlib/setenv.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/setenv.o lib/libc/stdlib/setenv.c

${OBJECTDIR}/lib/libc/stdlib/strtod.o: lib/libc/stdlib/strtod.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/strtod.o lib/libc/stdlib/strtod.c

${OBJECTDIR}/lib/libc/stdlib/strtol.o: lib/libc/stdlib/strtol.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/strtol.o lib/libc/stdlib/strtol.c

${OBJECTDIR}/lib/libc/stdlib/strtoq.o: lib/libc/stdlib/strtoq.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/strtoq.o lib/libc/stdlib/strtoq.c

${OBJECTDIR}/lib/libc/stdlib/strtoul.o: lib/libc/stdlib/strtoul.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/strtoul.o lib/libc/stdlib/strtoul.c

${OBJECTDIR}/lib/libc/stdlib/strtouq.o: lib/libc/stdlib/strtouq.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/stdlib
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/stdlib/strtouq.o lib/libc/stdlib/strtouq.c

${OBJECTDIR}/lib/libc/string/bcopy.o: lib/libc/string/bcopy.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/bcopy.o lib/libc/string/bcopy.c

${OBJECTDIR}/lib/libc/string/index.o: lib/libc/string/index.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/index.o lib/libc/string/index.c

${OBJECTDIR}/lib/libc/string/memccpy.o: lib/libc/string/memccpy.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/memccpy.o lib/libc/string/memccpy.c

${OBJECTDIR}/lib/libc/string/memchr.o: lib/libc/string/memchr.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/memchr.o lib/libc/string/memchr.c

${OBJECTDIR}/lib/libc/string/memcmp.o: lib/libc/string/memcmp.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/memcmp.o lib/libc/string/memcmp.c

${OBJECTDIR}/lib/libc/string/memset.o: lib/libc/string/memset.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/memset.o lib/libc/string/memset.c

${OBJECTDIR}/lib/libc/string/rindex2.o: lib/libc/string/rindex2.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/rindex2.o lib/libc/string/rindex2.c

${OBJECTDIR}/lib/libc/string/strcasecmp.o: lib/libc/string/strcasecmp.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strcasecmp.o lib/libc/string/strcasecmp.c

${OBJECTDIR}/lib/libc/string/strcat.o: lib/libc/string/strcat.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strcat.o lib/libc/string/strcat.c

${OBJECTDIR}/lib/libc/string/strcoll.o: lib/libc/string/strcoll.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strcoll.o lib/libc/string/strcoll.c

${OBJECTDIR}/lib/libc/string/strcpy.o: lib/libc/string/strcpy.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strcpy.o lib/libc/string/strcpy.c

${OBJECTDIR}/lib/libc/string/strcspn.o: lib/libc/string/strcspn.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strcspn.o lib/libc/string/strcspn.c

${OBJECTDIR}/lib/libc/string/strdup.o: lib/libc/string/strdup.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strdup.o lib/libc/string/strdup.c

${OBJECTDIR}/lib/libc/string/strerror.o: lib/libc/string/strerror.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strerror.o lib/libc/string/strerror.c

${OBJECTDIR}/lib/libc/string/strftime.o: lib/libc/string/strftime.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strftime.o lib/libc/string/strftime.c

${OBJECTDIR}/lib/libc/string/strlcat.o: lib/libc/string/strlcat.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strlcat.o lib/libc/string/strlcat.c

${OBJECTDIR}/lib/libc/string/strlcpy.o: lib/libc/string/strlcpy.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strlcpy.o lib/libc/string/strlcpy.c

${OBJECTDIR}/lib/libc/string/strmode.o: lib/libc/string/strmode.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strmode.o lib/libc/string/strmode.c

${OBJECTDIR}/lib/libc/string/strncat.o: lib/libc/string/strncat.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strncat.o lib/libc/string/strncat.c

${OBJECTDIR}/lib/libc/string/strncmp.o: lib/libc/string/strncmp.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strncmp.o lib/libc/string/strncmp.c

${OBJECTDIR}/lib/libc/string/strncpy.o: lib/libc/string/strncpy.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strncpy.o lib/libc/string/strncpy.c

${OBJECTDIR}/lib/libc/string/strpbrk.o: lib/libc/string/strpbrk.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strpbrk.o lib/libc/string/strpbrk.c

${OBJECTDIR}/lib/libc/string/strsep.o: lib/libc/string/strsep.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strsep.o lib/libc/string/strsep.c

${OBJECTDIR}/lib/libc/string/strspn.o: lib/libc/string/strspn.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strspn.o lib/libc/string/strspn.c

${OBJECTDIR}/lib/libc/string/strstr.o: lib/libc/string/strstr.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strstr.o lib/libc/string/strstr.c

${OBJECTDIR}/lib/libc/string/strtok.o: lib/libc/string/strtok.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strtok.o lib/libc/string/strtok.c

${OBJECTDIR}/lib/libc/string/strxfrm.o: lib/libc/string/strxfrm.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/strxfrm.o lib/libc/string/strxfrm.c

${OBJECTDIR}/lib/libc/string/swab.o: lib/libc/string/swab.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libc/string
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DMEMCOPY -DSTRCHR -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libc/string/swab.o lib/libc/string/swab.c

${OBJECTDIR}/lib/libm/common/atan2.o: lib/libm/common/atan2.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common/atan2.o lib/libm/common/atan2.c

${OBJECTDIR}/lib/libm/common/sincos.o: lib/libm/common/sincos.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common/sincos.o lib/libm/common/sincos.c

${OBJECTDIR}/lib/libm/common/tan.o: lib/libm/common/tan.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common/tan.o lib/libm/common/tan.c

${OBJECTDIR}/lib/libm/common_source/acosh.o: lib/libm/common_source/acosh.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/acosh.o lib/libm/common_source/acosh.c

${OBJECTDIR}/lib/libm/common_source/asincos.o: lib/libm/common_source/asincos.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/asincos.o lib/libm/common_source/asincos.c

${OBJECTDIR}/lib/libm/common_source/asinh.o: lib/libm/common_source/asinh.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/asinh.o lib/libm/common_source/asinh.c

${OBJECTDIR}/lib/libm/common_source/atan.o: lib/libm/common_source/atan.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/atan.o lib/libm/common_source/atan.c

${OBJECTDIR}/lib/libm/common_source/atanh.o: lib/libm/common_source/atanh.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/atanh.o lib/libm/common_source/atanh.c

${OBJECTDIR}/lib/libm/common_source/cosh.o: lib/libm/common_source/cosh.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/cosh.o lib/libm/common_source/cosh.c

${OBJECTDIR}/lib/libm/common_source/erf.o: lib/libm/common_source/erf.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/erf.o lib/libm/common_source/erf.c

${OBJECTDIR}/lib/libm/common_source/exp.o: lib/libm/common_source/exp.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/exp.o lib/libm/common_source/exp.c

${OBJECTDIR}/lib/libm/common_source/exp__E.o: lib/libm/common_source/exp__E.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/exp__E.o lib/libm/common_source/exp__E.c

${OBJECTDIR}/lib/libm/common_source/expm1.o: lib/libm/common_source/expm1.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/expm1.o lib/libm/common_source/expm1.c

${OBJECTDIR}/lib/libm/common_source/floor.o: lib/libm/common_source/floor.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/floor.o lib/libm/common_source/floor.c

${OBJECTDIR}/lib/libm/common_source/fmod.o: lib/libm/common_source/fmod.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/fmod.o lib/libm/common_source/fmod.c

${OBJECTDIR}/lib/libm/common_source/gamma.o: lib/libm/common_source/gamma.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/gamma.o lib/libm/common_source/gamma.c

${OBJECTDIR}/lib/libm/common_source/j0.o: lib/libm/common_source/j0.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/j0.o lib/libm/common_source/j0.c

${OBJECTDIR}/lib/libm/common_source/j1.o: lib/libm/common_source/j1.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/j1.o lib/libm/common_source/j1.c

${OBJECTDIR}/lib/libm/common_source/jn.o: lib/libm/common_source/jn.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/jn.o lib/libm/common_source/jn.c

${OBJECTDIR}/lib/libm/common_source/lgamma.o: lib/libm/common_source/lgamma.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/lgamma.o lib/libm/common_source/lgamma.c

${OBJECTDIR}/lib/libm/common_source/log.o: lib/libm/common_source/log.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/log.o lib/libm/common_source/log.c

${OBJECTDIR}/lib/libm/common_source/log10.o: lib/libm/common_source/log10.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/log10.o lib/libm/common_source/log10.c

${OBJECTDIR}/lib/libm/common_source/log1p.o: lib/libm/common_source/log1p.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/log1p.o lib/libm/common_source/log1p.c

${OBJECTDIR}/lib/libm/common_source/log__L.o: lib/libm/common_source/log__L.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/log__L.o lib/libm/common_source/log__L.c

${OBJECTDIR}/lib/libm/common_source/pow.o: lib/libm/common_source/pow.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/pow.o lib/libm/common_source/pow.c

${OBJECTDIR}/lib/libm/common_source/sinh.o: lib/libm/common_source/sinh.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/sinh.o lib/libm/common_source/sinh.c

${OBJECTDIR}/lib/libm/common_source/tanh.o: lib/libm/common_source/tanh.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/common_source
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/common_source/tanh.o lib/libm/common_source/tanh.c

${OBJECTDIR}/lib/libm/ieee/cabs.o: lib/libm/ieee/cabs.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/ieee
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/ieee/cabs.o lib/libm/ieee/cabs.c

${OBJECTDIR}/lib/libm/ieee/cbrt.o: lib/libm/ieee/cbrt.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/ieee
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/ieee/cbrt.o lib/libm/ieee/cbrt.c

${OBJECTDIR}/lib/libm/ieee/support.o: lib/libm/ieee/support.c 
	${MKDIR} -p ${OBJECTDIR}/lib/libm/ieee
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/libm/ieee/support.o lib/libm/ieee/support.c

${OBJECTDIR}/lib/list/list.o: lib/list/list.c 
	${MKDIR} -p ${OBJECTDIR}/lib/list
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/list/list.o lib/list/list.c

${OBJECTDIR}/lib/pthread/attr.o: lib/pthread/attr.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/attr.o lib/pthread/attr.c

${OBJECTDIR}/lib/pthread/cleanup.o: lib/pthread/cleanup.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/cleanup.o lib/pthread/cleanup.c

${OBJECTDIR}/lib/pthread/cond.o: lib/pthread/cond.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/cond.o lib/pthread/cond.c

${OBJECTDIR}/lib/pthread/create.o: lib/pthread/create.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/create.o lib/pthread/create.c

${OBJECTDIR}/lib/pthread/join.o: lib/pthread/join.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/join.o lib/pthread/join.c

${OBJECTDIR}/lib/pthread/key.o: lib/pthread/key.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/key.o lib/pthread/key.c

${OBJECTDIR}/lib/pthread/mutex.o: lib/pthread/mutex.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/mutex.o lib/pthread/mutex.c

${OBJECTDIR}/lib/pthread/once.o: lib/pthread/once.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/once.o lib/pthread/once.c

${OBJECTDIR}/lib/pthread/pthread.o: lib/pthread/pthread.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/pthread.o lib/pthread/pthread.c

${OBJECTDIR}/lib/pthread/self.o: lib/pthread/self.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/self.o lib/pthread/self.c

${OBJECTDIR}/lib/pthread/test.o: lib/pthread/test.c 
	${MKDIR} -p ${OBJECTDIR}/lib/pthread
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lib/pthread/test.o lib/pthread/test.c

${OBJECTDIR}/lwip/src/api/api_lib.o: lwip/src/api/api_lib.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/api_lib.o lwip/src/api/api_lib.c

${OBJECTDIR}/lwip/src/api/api_msg.o: lwip/src/api/api_msg.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/api_msg.o lwip/src/api/api_msg.c

${OBJECTDIR}/lwip/src/api/err.o: lwip/src/api/err.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/err.o lwip/src/api/err.c

${OBJECTDIR}/lwip/src/api/netbuf.o: lwip/src/api/netbuf.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/netbuf.o lwip/src/api/netbuf.c

${OBJECTDIR}/lwip/src/api/netdb.o: lwip/src/api/netdb.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/netdb.o lwip/src/api/netdb.c

${OBJECTDIR}/lwip/src/api/netifapi.o: lwip/src/api/netifapi.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/netifapi.o lwip/src/api/netifapi.c

${OBJECTDIR}/lwip/src/api/pppapi.o: lwip/src/api/pppapi.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/pppapi.o lwip/src/api/pppapi.c

${OBJECTDIR}/lwip/src/api/psockets.o: lwip/src/api/psockets.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/psockets.o lwip/src/api/psockets.c

${OBJECTDIR}/lwip/src/api/sockets.o: lwip/src/api/sockets.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/sockets.o lwip/src/api/sockets.c

${OBJECTDIR}/lwip/src/api/tcpip.o: lwip/src/api/tcpip.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/api
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/api/tcpip.o lwip/src/api/tcpip.c

${OBJECTDIR}/lwip/src/core/def.o: lwip/src/core/def.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/def.o lwip/src/core/def.c

${OBJECTDIR}/lwip/src/core/dhcp.o: lwip/src/core/dhcp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/dhcp.o lwip/src/core/dhcp.c

${OBJECTDIR}/lwip/src/core/dns.o: lwip/src/core/dns.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/dns.o lwip/src/core/dns.c

${OBJECTDIR}/lwip/src/core/inet_chksum.o: lwip/src/core/inet_chksum.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/inet_chksum.o lwip/src/core/inet_chksum.c

${OBJECTDIR}/lwip/src/core/init.o: lwip/src/core/init.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/init.o lwip/src/core/init.c

${OBJECTDIR}/lwip/src/core/ipv4/autoip.o: lwip/src/core/ipv4/autoip.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv4
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv4/autoip.o lwip/src/core/ipv4/autoip.c

${OBJECTDIR}/lwip/src/core/ipv4/icmp.o: lwip/src/core/ipv4/icmp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv4
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv4/icmp.o lwip/src/core/ipv4/icmp.c

${OBJECTDIR}/lwip/src/core/ipv4/igmp.o: lwip/src/core/ipv4/igmp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv4
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv4/igmp.o lwip/src/core/ipv4/igmp.c

${OBJECTDIR}/lwip/src/core/ipv4/ip4.o: lwip/src/core/ipv4/ip4.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv4
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv4/ip4.o lwip/src/core/ipv4/ip4.c

${OBJECTDIR}/lwip/src/core/ipv4/ip4_addr.o: lwip/src/core/ipv4/ip4_addr.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv4
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv4/ip4_addr.o lwip/src/core/ipv4/ip4_addr.c

${OBJECTDIR}/lwip/src/core/ipv4/ip_frag.o: lwip/src/core/ipv4/ip_frag.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv4
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv4/ip_frag.o lwip/src/core/ipv4/ip_frag.c

${OBJECTDIR}/lwip/src/core/ipv6/dhcp6.o: lwip/src/core/ipv6/dhcp6.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv6
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv6/dhcp6.o lwip/src/core/ipv6/dhcp6.c

${OBJECTDIR}/lwip/src/core/ipv6/ethip6.o: lwip/src/core/ipv6/ethip6.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv6
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv6/ethip6.o lwip/src/core/ipv6/ethip6.c

${OBJECTDIR}/lwip/src/core/ipv6/icmp6.o: lwip/src/core/ipv6/icmp6.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv6
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv6/icmp6.o lwip/src/core/ipv6/icmp6.c

${OBJECTDIR}/lwip/src/core/ipv6/inet6.o: lwip/src/core/ipv6/inet6.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv6
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv6/inet6.o lwip/src/core/ipv6/inet6.c

${OBJECTDIR}/lwip/src/core/ipv6/ip6.o: lwip/src/core/ipv6/ip6.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv6
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv6/ip6.o lwip/src/core/ipv6/ip6.c

${OBJECTDIR}/lwip/src/core/ipv6/ip6_addr.o: lwip/src/core/ipv6/ip6_addr.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv6
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv6/ip6_addr.o lwip/src/core/ipv6/ip6_addr.c

${OBJECTDIR}/lwip/src/core/ipv6/ip6_frag.o: lwip/src/core/ipv6/ip6_frag.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv6
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv6/ip6_frag.o lwip/src/core/ipv6/ip6_frag.c

${OBJECTDIR}/lwip/src/core/ipv6/mld6.o: lwip/src/core/ipv6/mld6.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv6
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv6/mld6.o lwip/src/core/ipv6/mld6.c

${OBJECTDIR}/lwip/src/core/ipv6/nd6.o: lwip/src/core/ipv6/nd6.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/ipv6
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ipv6/nd6.o lwip/src/core/ipv6/nd6.c

${OBJECTDIR}/lwip/src/core/mem.o: lwip/src/core/mem.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/mem.o lwip/src/core/mem.c

${OBJECTDIR}/lwip/src/core/memp.o: lwip/src/core/memp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/memp.o lwip/src/core/memp.c

${OBJECTDIR}/lwip/src/core/netif.o: lwip/src/core/netif.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/netif.o lwip/src/core/netif.c

${OBJECTDIR}/lwip/src/core/pbuf.o: lwip/src/core/pbuf.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/pbuf.o lwip/src/core/pbuf.c

${OBJECTDIR}/lwip/src/core/raw.o: lwip/src/core/raw.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/raw.o lwip/src/core/raw.c

${OBJECTDIR}/lwip/src/core/snmp/asn1_dec.o: lwip/src/core/snmp/asn1_dec.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/snmp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/snmp/asn1_dec.o lwip/src/core/snmp/asn1_dec.c

${OBJECTDIR}/lwip/src/core/snmp/asn1_enc.o: lwip/src/core/snmp/asn1_enc.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/snmp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/snmp/asn1_enc.o lwip/src/core/snmp/asn1_enc.c

${OBJECTDIR}/lwip/src/core/snmp/mib2.o: lwip/src/core/snmp/mib2.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/snmp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/snmp/mib2.o lwip/src/core/snmp/mib2.c

${OBJECTDIR}/lwip/src/core/snmp/mib_structs.o: lwip/src/core/snmp/mib_structs.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/snmp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/snmp/mib_structs.o lwip/src/core/snmp/mib_structs.c

${OBJECTDIR}/lwip/src/core/snmp/msg_in.o: lwip/src/core/snmp/msg_in.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/snmp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/snmp/msg_in.o lwip/src/core/snmp/msg_in.c

${OBJECTDIR}/lwip/src/core/snmp/msg_out.o: lwip/src/core/snmp/msg_out.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core/snmp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/snmp/msg_out.o lwip/src/core/snmp/msg_out.c

${OBJECTDIR}/lwip/src/core/sntp.o: lwip/src/core/sntp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/sntp.o lwip/src/core/sntp.c

${OBJECTDIR}/lwip/src/core/stats.o: lwip/src/core/stats.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/stats.o lwip/src/core/stats.c

${OBJECTDIR}/lwip/src/core/sys.o: lwip/src/core/sys.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/sys.o lwip/src/core/sys.c

${OBJECTDIR}/lwip/src/core/tcp.o: lwip/src/core/tcp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/tcp.o lwip/src/core/tcp.c

${OBJECTDIR}/lwip/src/core/tcp_in.o: lwip/src/core/tcp_in.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/tcp_in.o lwip/src/core/tcp_in.c

${OBJECTDIR}/lwip/src/core/tcp_out.o: lwip/src/core/tcp_out.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/tcp_out.o lwip/src/core/tcp_out.c

${OBJECTDIR}/lwip/src/core/ticker.o: lwip/src/core/ticker.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/ticker.o lwip/src/core/ticker.c

${OBJECTDIR}/lwip/src/core/timers.o: lwip/src/core/timers.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/timers.o lwip/src/core/timers.c

${OBJECTDIR}/lwip/src/core/udp.o: lwip/src/core/udp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/core
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/core/udp.o lwip/src/core/udp.c

${OBJECTDIR}/lwip/src/netif/etharp.o: lwip/src/netif/etharp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/etharp.o lwip/src/netif/etharp.c

${OBJECTDIR}/lwip/src/netif/ppp/auth.o: lwip/src/netif/ppp/auth.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/auth.o lwip/src/netif/ppp/auth.c

${OBJECTDIR}/lwip/src/netif/ppp/ccp.o: lwip/src/netif/ppp/ccp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/ccp.o lwip/src/netif/ppp/ccp.c

${OBJECTDIR}/lwip/src/netif/ppp/chap-md5.o: lwip/src/netif/ppp/chap-md5.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/chap-md5.o lwip/src/netif/ppp/chap-md5.c

${OBJECTDIR}/lwip/src/netif/ppp/chap-new.o: lwip/src/netif/ppp/chap-new.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/chap-new.o lwip/src/netif/ppp/chap-new.c

${OBJECTDIR}/lwip/src/netif/ppp/chap_ms.o: lwip/src/netif/ppp/chap_ms.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/chap_ms.o lwip/src/netif/ppp/chap_ms.c

${OBJECTDIR}/lwip/src/netif/ppp/demand.o: lwip/src/netif/ppp/demand.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/demand.o lwip/src/netif/ppp/demand.c

${OBJECTDIR}/lwip/src/netif/ppp/eap.o: lwip/src/netif/ppp/eap.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/eap.o lwip/src/netif/ppp/eap.c

${OBJECTDIR}/lwip/src/netif/ppp/ecp.o: lwip/src/netif/ppp/ecp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/ecp.o lwip/src/netif/ppp/ecp.c

${OBJECTDIR}/lwip/src/netif/ppp/eui64.o: lwip/src/netif/ppp/eui64.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/eui64.o lwip/src/netif/ppp/eui64.c

${OBJECTDIR}/lwip/src/netif/ppp/fsm.o: lwip/src/netif/ppp/fsm.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/fsm.o lwip/src/netif/ppp/fsm.c

${OBJECTDIR}/lwip/src/netif/ppp/ipcp.o: lwip/src/netif/ppp/ipcp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/ipcp.o lwip/src/netif/ppp/ipcp.c

${OBJECTDIR}/lwip/src/netif/ppp/ipv6cp.o: lwip/src/netif/ppp/ipv6cp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/ipv6cp.o lwip/src/netif/ppp/ipv6cp.c

${OBJECTDIR}/lwip/src/netif/ppp/lcp.o: lwip/src/netif/ppp/lcp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/lcp.o lwip/src/netif/ppp/lcp.c

${OBJECTDIR}/lwip/src/netif/ppp/magic.o: lwip/src/netif/ppp/magic.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/magic.o lwip/src/netif/ppp/magic.c

${OBJECTDIR}/lwip/src/netif/ppp/mppe.o: lwip/src/netif/ppp/mppe.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/mppe.o lwip/src/netif/ppp/mppe.c

${OBJECTDIR}/lwip/src/netif/ppp/multilink.o: lwip/src/netif/ppp/multilink.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/multilink.o lwip/src/netif/ppp/multilink.c

${OBJECTDIR}/lwip/src/netif/ppp/polarssl/arc4.o: lwip/src/netif/ppp/polarssl/arc4.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp/polarssl
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/polarssl/arc4.o lwip/src/netif/ppp/polarssl/arc4.c

${OBJECTDIR}/lwip/src/netif/ppp/polarssl/des.o: lwip/src/netif/ppp/polarssl/des.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp/polarssl
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/polarssl/des.o lwip/src/netif/ppp/polarssl/des.c

${OBJECTDIR}/lwip/src/netif/ppp/polarssl/md4.o: lwip/src/netif/ppp/polarssl/md4.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp/polarssl
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/polarssl/md4.o lwip/src/netif/ppp/polarssl/md4.c

${OBJECTDIR}/lwip/src/netif/ppp/polarssl/md5.o: lwip/src/netif/ppp/polarssl/md5.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp/polarssl
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/polarssl/md5.o lwip/src/netif/ppp/polarssl/md5.c

${OBJECTDIR}/lwip/src/netif/ppp/polarssl/sha1.o: lwip/src/netif/ppp/polarssl/sha1.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp/polarssl
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/polarssl/sha1.o lwip/src/netif/ppp/polarssl/sha1.c

${OBJECTDIR}/lwip/src/netif/ppp/ppp.o: lwip/src/netif/ppp/ppp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/ppp.o lwip/src/netif/ppp/ppp.c

${OBJECTDIR}/lwip/src/netif/ppp/pppcrypt.o: lwip/src/netif/ppp/pppcrypt.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/pppcrypt.o lwip/src/netif/ppp/pppcrypt.c

${OBJECTDIR}/lwip/src/netif/ppp/pppoe.o: lwip/src/netif/ppp/pppoe.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/pppoe.o lwip/src/netif/ppp/pppoe.c

${OBJECTDIR}/lwip/src/netif/ppp/pppol2tp.o: lwip/src/netif/ppp/pppol2tp.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/pppol2tp.o lwip/src/netif/ppp/pppol2tp.c

${OBJECTDIR}/lwip/src/netif/ppp/pppos.o: lwip/src/netif/ppp/pppos.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/pppos.o lwip/src/netif/ppp/pppos.c

${OBJECTDIR}/lwip/src/netif/ppp/upap.o: lwip/src/netif/ppp/upap.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/upap.o lwip/src/netif/ppp/upap.c

${OBJECTDIR}/lwip/src/netif/ppp/utils.o: lwip/src/netif/ppp/utils.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/utils.o lwip/src/netif/ppp/utils.c

${OBJECTDIR}/lwip/src/netif/ppp/vj.o: lwip/src/netif/ppp/vj.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif/ppp
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/ppp/vj.o lwip/src/netif/ppp/vj.c

${OBJECTDIR}/lwip/src/netif/slipif.o: lwip/src/netif/slipif.c 
	${MKDIR} -p ${OBJECTDIR}/lwip/src/netif
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/lwip/src/netif/slipif.o lwip/src/netif/slipif.c

${OBJECTDIR}/main/machdep.o: main/machdep.c 
	${MKDIR} -p ${OBJECTDIR}/main
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main/machdep.o main/machdep.c

${OBJECTDIR}/main/machdev.o: main/machdev.c 
	${MKDIR} -p ${OBJECTDIR}/main
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main/machdev.o main/machdev.c

${OBJECTDIR}/main/main.o: main/main.c 
	${MKDIR} -p ${OBJECTDIR}/main
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main/main.o main/main.c

${OBJECTDIR}/main/sys_arch.o: main/sys_arch.c 
	${MKDIR} -p ${OBJECTDIR}/main
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main/sys_arch.o main/sys_arch.c

${OBJECTDIR}/main/tests.o: main/tests.c 
	${MKDIR} -p ${OBJECTDIR}/main
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main/tests.o main/tests.c

${OBJECTDIR}/main/trap.o: main/trap.c 
	${MKDIR} -p ${OBJECTDIR}/main
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main/trap.o main/trap.c

${OBJECTDIR}/mqtt/Clients.o: mqtt/Clients.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/Clients.o mqtt/Clients.c

${OBJECTDIR}/mqtt/LinkedList.o: mqtt/LinkedList.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/LinkedList.o mqtt/LinkedList.c

${OBJECTDIR}/mqtt/Log.o: mqtt/Log.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/Log.o mqtt/Log.c

${OBJECTDIR}/mqtt/MQTTClient.o: mqtt/MQTTClient.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/MQTTClient.o mqtt/MQTTClient.c

${OBJECTDIR}/mqtt/MQTTPacket.o: mqtt/MQTTPacket.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/MQTTPacket.o mqtt/MQTTPacket.c

${OBJECTDIR}/mqtt/MQTTPacketOut.o: mqtt/MQTTPacketOut.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/MQTTPacketOut.o mqtt/MQTTPacketOut.c

${OBJECTDIR}/mqtt/MQTTProtocolClient.o: mqtt/MQTTProtocolClient.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/MQTTProtocolClient.o mqtt/MQTTProtocolClient.c

${OBJECTDIR}/mqtt/MQTTProtocolOut.o: mqtt/MQTTProtocolOut.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/MQTTProtocolOut.o mqtt/MQTTProtocolOut.c

${OBJECTDIR}/mqtt/Messages.o: mqtt/Messages.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/Messages.o mqtt/Messages.c

${OBJECTDIR}/mqtt/SSLSocket.o: mqtt/SSLSocket.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/SSLSocket.o mqtt/SSLSocket.c

${OBJECTDIR}/mqtt/Socket.o: mqtt/Socket.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/Socket.o mqtt/Socket.c

${OBJECTDIR}/mqtt/SocketBuffer.o: mqtt/SocketBuffer.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/SocketBuffer.o mqtt/SocketBuffer.c

${OBJECTDIR}/mqtt/Thread.o: mqtt/Thread.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/Thread.o mqtt/Thread.c

${OBJECTDIR}/mqtt/utf-8.o: mqtt/utf-8.c 
	${MKDIR} -p ${OBJECTDIR}/mqtt
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DNO_PERSISTENCE -DNOSTACKTRACE -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/mqtt/utf-8.o mqtt/utf-8.c

${OBJECTDIR}/sys/fat/diskio.o: sys/fat/diskio.c 
	${MKDIR} -p ${OBJECTDIR}/sys/fat
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/fat/diskio.o sys/fat/diskio.c

${OBJECTDIR}/sys/fat/ff.o: sys/fat/ff.c 
	${MKDIR} -p ${OBJECTDIR}/sys/fat
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/fat/ff.o sys/fat/ff.c

${OBJECTDIR}/sys/fat/option/syscall.o: sys/fat/option/syscall.c 
	${MKDIR} -p ${OBJECTDIR}/sys/fat/option
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/fat/option/syscall.o sys/fat/option/syscall.c

${OBJECTDIR}/sys/fat/option/unicode.o: sys/fat/option/unicode.c 
	${MKDIR} -p ${OBJECTDIR}/sys/fat/option
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/fat/option/unicode.o sys/fat/option/unicode.c

${OBJECTDIR}/sys/spiffs/spiffs_cache.o: sys/spiffs/spiffs_cache.c 
	${MKDIR} -p ${OBJECTDIR}/sys/spiffs
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/spiffs/spiffs_cache.o sys/spiffs/spiffs_cache.c

${OBJECTDIR}/sys/spiffs/spiffs_check.o: sys/spiffs/spiffs_check.c 
	${MKDIR} -p ${OBJECTDIR}/sys/spiffs
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/spiffs/spiffs_check.o sys/spiffs/spiffs_check.c

${OBJECTDIR}/sys/spiffs/spiffs_gc.o: sys/spiffs/spiffs_gc.c 
	${MKDIR} -p ${OBJECTDIR}/sys/spiffs
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/spiffs/spiffs_gc.o sys/spiffs/spiffs_gc.c

${OBJECTDIR}/sys/spiffs/spiffs_hydrogen.o: sys/spiffs/spiffs_hydrogen.c 
	${MKDIR} -p ${OBJECTDIR}/sys/spiffs
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/spiffs/spiffs_hydrogen.o sys/spiffs/spiffs_hydrogen.c

${OBJECTDIR}/sys/spiffs/spiffs_nucleus.o: sys/spiffs/spiffs_nucleus.c 
	${MKDIR} -p ${OBJECTDIR}/sys/spiffs
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/spiffs/spiffs_nucleus.o sys/spiffs/spiffs_nucleus.c

${OBJECTDIR}/sys/syscalls/__sysctl.o: sys/syscalls/__sysctl.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/__sysctl.o sys/syscalls/__sysctl.c

${OBJECTDIR}/sys/syscalls/_exit.o: sys/syscalls/_exit.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/_exit.o sys/syscalls/_exit.c

${OBJECTDIR}/sys/syscalls/descrip.o: sys/syscalls/descrip.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/descrip.o sys/syscalls/descrip.c

${OBJECTDIR}/sys/syscalls/fs.o: sys/syscalls/fs.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/fs.o sys/syscalls/fs.c

${OBJECTDIR}/sys/syscalls/generic.o: sys/syscalls/generic.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/generic.o sys/syscalls/generic.c

${OBJECTDIR}/sys/syscalls/getrusage.o: sys/syscalls/getrusage.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/getrusage.o sys/syscalls/getrusage.c

${OBJECTDIR}/sys/syscalls/ioctl.o: sys/syscalls/ioctl.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/ioctl.o sys/syscalls/ioctl.c

${OBJECTDIR}/sys/syscalls/lseek.o: sys/syscalls/lseek.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/lseek.o sys/syscalls/lseek.c

${OBJECTDIR}/sys/syscalls/mkdir.o: sys/syscalls/mkdir.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/mkdir.o sys/syscalls/mkdir.c

${OBJECTDIR}/sys/syscalls/mmap.o: sys/syscalls/mmap.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/mmap.o sys/syscalls/mmap.c

${OBJECTDIR}/sys/syscalls/mount.o: sys/syscalls/mount.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/mount.o sys/syscalls/mount.c

${OBJECTDIR}/sys/syscalls/mutex.o: sys/syscalls/mutex.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/mutex.o sys/syscalls/mutex.c

${OBJECTDIR}/sys/syscalls/open.o: sys/syscalls/open.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/open.o sys/syscalls/open.c

${OBJECTDIR}/sys/syscalls/ops/fat_ops.o: sys/syscalls/ops/fat_ops.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls/ops
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/ops/fat_ops.o sys/syscalls/ops/fat_ops.c

${OBJECTDIR}/sys/syscalls/ops/net_ops.o: sys/syscalls/ops/net_ops.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls/ops
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/ops/net_ops.o sys/syscalls/ops/net_ops.c

${OBJECTDIR}/sys/syscalls/ops/spiffs_ops.o: sys/syscalls/ops/spiffs_ops.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls/ops
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/ops/spiffs_ops.o sys/syscalls/ops/spiffs_ops.c

${OBJECTDIR}/sys/syscalls/ops/tty_ops.o: sys/syscalls/ops/tty_ops.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls/ops
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/ops/tty_ops.o sys/syscalls/ops/tty_ops.c

${OBJECTDIR}/sys/syscalls/prot.o: sys/syscalls/prot.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/prot.o sys/syscalls/prot.c

${OBJECTDIR}/sys/syscalls/rename.o: sys/syscalls/rename.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/rename.o sys/syscalls/rename.c

${OBJECTDIR}/sys/syscalls/select.o: sys/syscalls/select.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/select.o sys/syscalls/select.c

${OBJECTDIR}/sys/syscalls/sigblock.o: sys/syscalls/sigblock.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/sigblock.o sys/syscalls/sigblock.c

${OBJECTDIR}/sys/syscalls/sigprocmask.o: sys/syscalls/sigprocmask.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/sigprocmask.o sys/syscalls/sigprocmask.c

${OBJECTDIR}/sys/syscalls/stack.o: sys/syscalls/stack.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/stack.o sys/syscalls/stack.c

${OBJECTDIR}/sys/syscalls/stat.o: sys/syscalls/stat.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/stat.o sys/syscalls/stat.c

${OBJECTDIR}/sys/syscalls/system.o: sys/syscalls/system.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/system.o sys/syscalls/system.c

${OBJECTDIR}/sys/syscalls/umask.o: sys/syscalls/umask.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/umask.o sys/syscalls/umask.c

${OBJECTDIR}/sys/syscalls/unlink.o: sys/syscalls/unlink.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/unlink.o sys/syscalls/unlink.c

${OBJECTDIR}/sys/syscalls/utime.o: sys/syscalls/utime.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/utime.o sys/syscalls/utime.c

${OBJECTDIR}/sys/syscalls/utimes.o: sys/syscalls/utimes.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/utimes.o sys/syscalls/utimes.c

${OBJECTDIR}/sys/syscalls/wait4.o: sys/syscalls/wait4.c 
	${MKDIR} -p ${OBJECTDIR}/sys/syscalls
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -DKERNEL -DKERNEL -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/sys/syscalls/wait4.o sys/syscalls/wait4.c

${OBJECTDIR}/utils/delay.o: utils/delay.c 
	${MKDIR} -p ${OBJECTDIR}/utils
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/utils/delay.o utils/delay.c

${OBJECTDIR}/utils/edit.o: utils/edit.c 
	${MKDIR} -p ${OBJECTDIR}/utils
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/utils/edit.o utils/edit.c

${OBJECTDIR}/utils/ping.o: utils/ping.c 
	${MKDIR} -p ${OBJECTDIR}/utils
	${RM} "$@.d"
	$(COMPILE.c) -g -I. -IFreeRTOS -IFreeRTOS/common/include -IFreeRTOS/port -Imain -Iinclude -Isys -Isys/fat -Isys/spiffs -Isys/syscalls -Imachine -Ilwip/src/include -Ilwip/src/include/lwip -Imqtt -ILua/5.3.1 -ILua/elua/inc -ILua/modules -ILua/platform -Ilib/libm/common_source -Ilib/pthread -ILua/exec/include -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/utils/ping.o utils/ping.c

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/luaos_v1

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
