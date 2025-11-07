#!/bin/bash

if [ ! -f /aix/images/aix-hdd.qcow2 ]; then
  qemu-img create -f qcow2 /aix/images/aix-hdd.qcow2 8G
fi

exec qemu-system-ppc -M 40p -bios /aix/q40pofw-serial.rom -serial telnet::4441,server,nowait -hda aix-hdd.qcow2 -cdrom AIX-vol1.iso -vga none -nographic
