# Run AIX 5.1 in Docker or Podman
I don't know why anyone would want to do this, but now you can. Multistage build, so the actual runtime (excluding AIX itself) is less than 200mbs, might be more later.

## Dependencies
- git
- telnet
- docker, docker-compose OR
- podman, podman-docker (maybe), podman-compose

## How to use
- Clone repo
- Create a directory named images/ in it
- Download [AIX 5.1](https://winworldpc.com/product/aix/51), you only really need volume 1 to install, everything else is extra packages.
- put .isos in the images/ directory, rename VOLUME1.iso to AIX-vol1.iso, or change the Dockerfile
- Docker will create a .qcow2 file for your AIX hdd in the images/ dir aswell
- Run docker/podman-compose build 
- Run docker/podman-compose up -d
- type in telnet localhost 4441, if 1st install type in boot cdrom:2 at ok prompt, if its already installed boot disk at ok prompt
- Install AIX 5.1, be happy 

## Some other things
Networking is not enabled right now, I'll add that later, neither is VNC, but you can remove --disable-vnc at the build stage and the commented out part in the runtime dependencies, that'll put in VNC support, probably won't work automatically. Also nothing works on debian 13+ so thats why its built on bullseye. Based on [Artyom Tarashenko's](https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html) writeup, many thanks to him.
