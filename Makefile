
fel:
	./sunxi-tools/sunxi-fel -v -p spl binaries/sunxi-spl.bin write 0x44000 binaries/bl31.bin write 0x4a000000 binaries/u-boot.bin reset64 0x44000

fel-new:
	./sunxi-tools/sunxi-fel -v -p spl binaries/new/sunxi-spl.bin write 0x44000 binaries/new/bl31.bin write 0x4a000000 binaries/new/u-boot.bin reset64 0x44000

fel-windows:
	.\sunxi-tools\sunxi-fel.exe -v -p spl binaries\sunxi-spl.bin write 0x44000 binaries\bl31.bin write 0x4a000000 binaries\u-boot.bin reset64 0x44000

tty:
	screen /dev/ttyUSB0 115200

acm:
	screen /dev/ttyACM0 115200
