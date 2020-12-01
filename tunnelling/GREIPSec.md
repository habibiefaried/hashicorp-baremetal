# GREIPSec

IPSec use GRE encapsulation with OpenVSwitch. WARNING! **This is not working** for operating layer 4 or above due to ISP Firewall/switches/routers that do not treat this packet properly.

On IP 161.97.158.40

```
ovs-vsctl add-br br-ipsec 
ip addr add 192.168.1.1/24 dev br-ipsec
ip link set br-ipsec up
ovs-vsctl add-port br-ipsec tun1-2
ovs-vsctl set interface tun1-2 type=gre options:remote_ip=161.97.158.38 options:psk=swordF1sh
ovs-vsctl add-port br-ipsec tun1-3
ovs-vsctl set interface tun1-3 type=gre options:remote_ip=161.97.158.37 options:psk=swordF1sh
```

On IP 161.97.158.38

```
ovs-vsctl add-br br-ipsec 
ip addr add 192.168.1.2/24 dev br-ipsec
ip link set br-ipsec up
ovs-vsctl add-port br-ipsec tun2-1
ovs-vsctl set interface tun2-1 type=gre options:remote_ip=161.97.158.40 options:psk=swordF1sh
```

On IP 161.97.158.37

```
ovs-vsctl add-br br-ipsec 
ip addr add 192.168.1.3/24 dev br-ipsec
ip link set br-ipsec up
ovs-vsctl add-port br-ipsec tun3-1
ovs-vsctl set interface tun3-1 type=gre options:remote_ip=161.97.158.40 options:psk=swordF1sh
```