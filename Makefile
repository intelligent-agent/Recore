
rev=a5

fel:
	./sunxi-tools/sunxi-fel -v -p spl binaries/sunxi-spl.bin write 0x44000 binaries/bl31.bin write 0x4a000000 binaries/u-boot-${rev}.bin reset64 0x44000

tty:
	minicom -D /dev/ttyUSB0 -w
