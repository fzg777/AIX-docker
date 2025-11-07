# Run AIX 5.1 in Docker or Podman
I don't know why anyone would want to do this, but now you can.

## Dependencies
- git
- telnet
- docker, docker-compose OR
- podman, podman-docker (maybe), podman-compose

## How to use
- Clone repo
- Create a directory named images/ in it
- Download [AIX 5.1](https://winworldpc.com/product/aix/51), you only really need volume 1-3
- put .isos in the images/ directory, rename VOLUME1.iso to AIX-vol1.iso, or change the Dockerfile
- Run docker/podman-compose build 
- Run docker/podman-compose up -d
- type in telnet localhost 4441, if 1st install boot cdrom:2, if its already installed boot disk
