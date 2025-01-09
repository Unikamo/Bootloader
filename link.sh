nasm -f bin -o boot.bin boot.S
qemu-system-i386 -drive format=raw,file=boot.bin

