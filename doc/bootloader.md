# Bootloader

The whitecat has a built-in bootloader for upgrade the board's firmware. Using 
the bootloader you don't need any additional hardware for upgrade your board.

Whitecat bootloader uses the STK500 communication protocol, so you can use any 
STK500 compatible software on your desktop for upgrade the board. We recommend 
to use [pic32prog](https://github.com/sergev/pic32prog).


### Whow to use the bootloader

#### 1. Install the desktop software

For Mac OS:

```
$ cd /usr/local/bin
$ sudo wget http://whitecatboard.org/dist/desktop/mac/pic32prog
```

#### 2. Get last whitecat firmware

For Mac OS:

```
$ cd $HOME
$ wget http://whitecatboard.org/dist/whitecat.hex
```

#### 3. Close terminal sessions

If you are connected to the whitecat console close your terminal program (
minicom, hyperterminal, etc ...).

#### 4. Upgrade whitecat firmware

First reset the whitecat connecting MLCR (P05) to GND (P04) for a little while, 
then disconnectc MLCR (P05) from GND (P04), and in the next 4 seconds, run one 
of the folowwing commands.

For Mac OS:

```
$ pic32prog -S -d /dev/tty.SLAB_USBtoUART whitecat.hex
```


### Whow to upgrade the bootloader

For upgrade the bootloader you need additional hardware. We recommend to use 
[PICkit 2](http://www.microchip.com/Developmenttools/ProductDetails.aspx?PartNO=DV164121). 

#### 1. Install the desktop software

For Mac OS:

```
$ cd /usr/local/bin
$ sudo wget http://whitecatboard.org/dist/desktop/mac/pic32prog
```

#### 2. Get last whitecat bootloader

For Mac OS:

```
$ cd $HOME
$ wget http://whitecatboard.org/dist/bootloader.hex
```

#### 3. Connect PICkit 2

Connect the PICkit 2 device to the whitecat:

| whitecat pin  | PICkit 2 pin  |
| ------------- |:-------------:|
| P05 (MCLR)    | 1             |
| P14 (RB6)     | 5             |
| P15 (RB7)     | 4             |

Then connect PICkit 2 to a free USB port on your desktop.

#### 4. Connect the whitecat

Connect the whitecat to a free USB port on your desktop.

#### 5. Upgrade whitecat bootloader

For Mac OS:

```
$ pic32prog -S bootloader.hex
```