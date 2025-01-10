#!/bin/bash

echo "1. Link boot.S && launch QEMU"
echo "2. Launch QEMU"
echo "3. (Re)Create virtual disk"

read answer

if [ "$answer" -eq 1 ]; then
	nasm -f bin -o boot.bin boot.S
	echo "File linked, do you want to recreate the virtual disk (y/n) ? (Bootloader won't be updated until you do it)"
	read disk_answer

	if [[ "$disk_answer" -eq "yes" || "$disk_answer" -eq "y" ]]; then
		qemu-img create -f raw disk.img 1G
		dd if=boot.bin of=disk.img bs=512 seek=0
		echo "Disk (re)created: disk.img"
	elif [[ "$disk_answer" -eq "no" || "$disk_answer" -eq "n" ]]; then
		echo "Disk was not re-created."
	else
		echo "Answer : \"y/yes || n/no\""
	fi
	
	qemu-system-i386 \
	-drive format=raw,file=disk.img,if=ide,index=1 \
	-boot order=c # A && B for Floppy ; C for HD 
	
	echo "QEMU launched."
elif [ "$answer" -eq 2 ]; then
	qemu-system-i386 \
	-drive format=raw,file=disk.img,if=ide,index=1 \
	-boot order=c # A && B for Floppy ; C for HD
	
	echo "QEMU launched."
elif [ "$answer" -eq 3 ]; then
	qemu-img create -f raw disk.img 5G
	dd if=boot.bin of=disk.img bs=512 seek=0
	
	echo "Disk (re)created: disk.img"
else
	 echo "Usage : \"./utils.sh [CHOICE]\""
fi
