FROM debian:bullseye-slim

WORKDIR /aix
RUN echo "deb-src http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list

RUN apt update && apt install -y git wget bash build-essential && apt build-dep -y qemu

RUN git clone --branch 40p-20190406-aix-boots --single-branch https://github.com/artyom-tarasenko/qemu.git && wget https://github.com/artyom-tarasenko/openfirmware/releases/download/40p-20190413/q40pofw-serial.rom

RUN cd qemu && ./configure --target-list=ppc-softmmu --python=/usr/bin/python3 --disable-werror --disable-glusterfs --disable-sdl --disable-gtk --disable-vte --disable-opengl --disable-curses --disable-virglrenderer && make && make install

VOLUME /aix/images
WORKDIR /aix/images

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
