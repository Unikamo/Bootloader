#!/bin/bash

echo "1. Link boot.S && launch QEMU"
echo "2. Launch QEMU"
echo "3. (Re)Create virtual disk"

read answer

if [ "$answer" -eq 1 ]; then
    nasm -f bin -o boot.bin boot.S
    echo "File linked, launching QEMU..."
    qemu-system-i386 \
  -drive format=raw,file=boot.bin,if=floppy \
  -drive format=raw,file=disk.img,if=ide,index=0
    echo "QEMU launched."
elif [ "$answer" -eq 2 ]; then
    qemu-system-i386 \
  -drive format=raw,file=boot.bin,if=floppy \
  -drive format=raw,file=disk.img,if=ide,index=0

    echo "QEMU launched."
elif [ "$answer" -eq 3 ]; then
    qemu-img create -f raw disk.img 10M
    echo "Disk (re)created: disk.img"
else
    echo "Usage : \"./utils.sh [CHOICE]\""
fi
