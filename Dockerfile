### build ###
FROM debian:bullseye-slim AS builder

WORKDIR /aix

RUN echo "deb-src http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list

RUN apt update && apt install -y git wget bash build-essential && apt build-dep -y qemu

RUN git clone --branch 40p-20190406-aix-boots --single-branch https://github.com/artyom-tarasenko/qemu.git && wget https://github.com/artyom-tarasenko/openfirmware/releases/download/40p-20190413/q40pofw-serial.rom

RUN cd qemu && ./configure --target-list=ppc-softmmu --python=/usr/bin/python3 --prefix=/usr/local --disable-werror --disable-glusterfs --disable-sdl --disable-gtk --disable-vte --disable-opengl --disable-curses --disable-virglrenderer --disable-brlapi --disable-spice --disable-smartcard --disable-libusb --disable-usb-redir --disable-guest-agent --disable-seccomp --disable-xen --disable-linux-aio --disable-cap-ng --disable-attr --disable-vhost-net --disable-vhost-crypto --disable-vhost-user --disable-docs --disable-rdma --disable-pvrdma --disable-vde --disable-netmap --disable-capstone --disable-curl --disable-vnc --audio-drv-list="" && make && make install DESTDIR=/aix/install

### hopefully smaller container ###
FROM debian:bullseye-slim

WORKDIR /aix

# actual dependencies
RUN apt update && apt install -y libglib2.0-0 libpixman-1-0 libfdt1 zlib1g libnuma1 libpmem1 librbd1 libiscsi7 libcurl4 libnfs13 libssh-4 libslirp0 wget && rm -rf /var/lib/apt/lists/*

# networking dependencies
RUN apt update && apt install -y bridge-utils uml-utilities net-tools iptables procps iproute2

# VNC dependencies
# RUN apt install -y libsasl2-2 libgnutls30 libjpeg62-turbo libpng16-16 

RUN wget https://github.com/artyom-tarasenko/openfirmware/releases/download/40p-20190413/q40pofw-serial.rom

COPY --from=builder /aix/install/usr/local /usr/local

# Set up networking
COPY network.sh /aix/network.sh
RUN chmod +x /aix/network.sh

COPY qemu-ifup /etc/qemu-ifup
RUN chmod +x /etc/qemu-ifup

VOLUME /aix/images
WORKDIR /aix/images

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
