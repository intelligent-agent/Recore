# Recore
Repository for Recore 3D printer control board

## What is in here?
- Schematics
- 3D models of the board
- Device tree binaries and sources
- Special binaries for booting the board in FEL mode
- Calibration and testing data from the manufacturing process.

## Note about binaries
There are binaries for booting the board in FEL mode with a
USB drive insered. This method bypasses the eMMC completely.
The three files
- sunxi-spl.bin
- bl31.bin
- u-boot-a5.bin

are used to boot a board in FEL mode. See Makefile
for instructions to use those for a specific revision.

## Sources
The binaries are identical to the what is used in Refactor distro,
the source code is available here:  
https://github.com/intelligent-agent/u-boot and  
https://github.com/intelligent-agent/arm-trusted-firmware  
The only differece is the boot command. In the stock image:  
`run distro_bootcmd`  
in the FEL binaries:   
`run bootcmd_usb0`

## Prerequisites for booting in FEL mode
On a Linux computer, in the folder with this README:
```
git clone https://github.com/linux-sunxi/sunxi-tools
cd sunxi-tools
make
cd ..
```
## Starting the board in FEL-mode
Hold down the button marked `fel` while applying power.
The PMIC/power LED should come on. The board must be connected to a host computer through the USB C connector. When the board is in FEL-mode, it should show up as
a USB device on the host computer:  
`lsusb`  
should show:  
`Allwinner Technology sunxi SoC OTG connector in FEL/flashing mode`

Then use the Makfile to run:  
`make fel`
