tunctl -t tap0 -u root && \
ifconfig tap0 up && \
brctl addbr br0 && \
brctl setfd br0 0 && \
ifconfig br0 10.0.2.2 netmask 255.255.255.0 broadcast 10.0.2.255 up && \
brctl addif br0 tap0 && \
ifconfig tap0 0.0.0.0 && \
sysctl net.ipv4.ip_forward=1 && \
iptables --table nat -A POSTROUTING --out-interface eth0 -j MASQUERADE
