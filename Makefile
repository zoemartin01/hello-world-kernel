link: remove_old_build compile_bootstrap compile_kernel linker.ld
	@echo "Linking the Kernel"
	i686-elf-gcc -T linker.ld -o build/myos.bin -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o -lgcc

compile_kernel: kernel.c
	@echo "Compiling kernel"
	i686-elf-gcc -c kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

compile_bootstrap: boot.s
	@echo "Compiling bootstrap assembly"
	i686-elf-as boot.s -o build/boot.o

remove_old_build:
	@echo "Removing old build"
	rm -r build
	mkdir build

run: link
	@echo "Starting qemu"
	qemu-system-i386 -kernel build/myos.bin