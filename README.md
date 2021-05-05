# Recore
Repository for Recore single board 3D printer control card


## What is in here?
- Schematics
- Device tree binary and source
- Special binaries for booting the board in FEL mode
- Calibration and testing data from the manufacturing process. 

## Note about binaries
There are binaries for booting the board from emmc/USB and 
binaries for booing the board from FEL mode. 
FEL-mode requires the board to boot in 32-bit mode. 
The files named ```u-boot-sunxi-with-spl-A4.bin``` etc. 
is used to boot from eMMC/USB while the three files
- sunxi-spl-a4.bin
- bl31.bin
- u-boot-a4.bin
are used to boot a board in FEL mode. See Makefile
for instructions to use those for a specific revision.


## prerequisites for booting in FEL mode
git clone https://github.com/linux-sunxi/sunxi-tools

Follow insttructions to install. 

## Starting the board in FEL-mode
make fel
