
fel:
	./sunxi-tools/sunxi-fel -v -p spl sunxi-spl.bin write 0x44000 bl31.bin write 0x4a000000 u-boot.bin reset64 0x44000

tty:
	minicom -D /dev/ttyUSB0 -w
