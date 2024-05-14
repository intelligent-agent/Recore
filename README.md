# Recore
Repository for Recore 3D printer control board

## What is in here?
- Schematics for Recore etc.
- 3D models of Recore
- Device tree sources
- Special binaries for booting the board in FEL mode
- Calibration and testing data from the manufacturing process

## Note about binaries
There are binaries for booting the board in FEL mode with a
USB drive insered. This method bypasses the eMMC completely.
The three files
- sunxi-spl.bin
- bl31.bin
- u-boot.bin

are used to boot a board in FEL mode. See Makefile
for instructions to use those for a specific revision.

The file `configs/recore_fel_config` is used to compile the new u-boot binaries, 
it is based on u-boot-v2022.07. 

## Sources
The binaries are identical to the what is used in Refactor/Rebuild distro,
the source code is available here:  
https://github.com/intelligent-agent/u-boot and  
https://github.com/intelligent-agent/arm-trusted-firmware  
The only differece is the boot command. In the stock image:  
`run distro_bootcmd`  
in the FEL binaries:   
`run bootcmd_usb0`

## Installing the sunxi-tools package. 
In order to boot the board from FEL-mode, the program `sunxi-fel` must be available. 
In recent versions of Debian (Bookworm and later) and derivatives, this can be installed from apt. 
```
sudo apt install sunxi-tools
```
On older versions of Debian, the sunxi-tools package does not have support for Allwinner A64. 
If that is the case, the program can be downloaded and installed with these instructions:
```
git clone https://github.com/linux-sunxi/sunxi-tools
cd sunxi-tools
make
sudo make install
```

## Starting the board in FEL-mode
Hold down the button marked `fel` while applying power.
The PMIC/power LED should come on. The board must be connected to a host computer through the USB C connector. When the board is in FEL-mode, it should show up as
a USB device on the host computer:  
`lsusb`  
should show:  
`Allwinner Technology sunxi SoC OTG connector in FEL/flashing mode`

Then use the Makefile to run:  
`make fel`

