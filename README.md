# hashicorp-baremetal

Hashicorp stack on baremetal deployment

# Spec

* 3 VPS S SSD servers on contabo.com (public IP only)
* We are using 192.168.1.0/24 for our private networking. With mapping:
  * 161.97.158.40 with 192.168.1.1, for consul server only
  *	161.97.158.38 with 192.168.1.2, for nomad server, with consul client
  *	161.97.158.37 with 192.168.1.3, for nomad client, with consul client
* IPSec PSK: `swordF1sh`
* OS: Debian 10

# OVS Setup for these 3 hosts

On IP 161.97.158.40

```
ovs-vsctl add-br br-ipsec 
ip addr add 192.168.1.1/24 dev br-ipsec
ip link set br-ipsec up
ovs-vsctl set Open_vSwitch . other_config:ipsec_skb_mark=0/1
ovs-vsctl add-port br-ipsec tun1-2
ovs-vsctl set interface tun1-2 type=gre options:remote_ip=161.97.158.38 options:psk=swordF1sh
ovs-vsctl add-port br-ipsec tun1-3
ovs-vsctl set interface tun1-3 type=gre options:remote_ip=161.97.158.37 options:psk=swordF1sh
ovs-vsctl set interface br-ipsec cfm_mpid=1
```

On IP 161.97.158.38

```
ovs-vsctl add-br br-ipsec 
ip addr add 192.168.1.2/24 dev br-ipsec
ip link set br-ipsec up
ovs-vsctl set Open_vSwitch . other_config:ipsec_skb_mark=0/1
ovs-vsctl add-port br-ipsec tun2-1
ovs-vsctl set interface tun2-1 type=gre options:remote_ip=161.97.158.40 options:psk=swordF1sh
ovs-vsctl add-port br-ipsec tun2-3
ovs-vsctl set interface tun2-3 type=gre options:remote_ip=161.97.158.37 options:psk=swordF1sh
ovs-vsctl set Interface br-ipsec cfm_mpid=1
```

On IP 161.97.158.37

```
ovs-vsctl add-br br-ipsec 
ip addr add 192.168.1.3/24 dev br-ipsec
ip link set br-ipsec up
ovs-vsctl set Open_vSwitch . other_config:ipsec_skb_mark=0/1
ovs-vsctl add-port br-ipsec tun3-1
ovs-vsctl set interface tun3-1 type=gre options:remote_ip=161.97.158.40 options:psk=swordF1sh
ovs-vsctl set Interface br-ipsec cfm_mpid=1
```

# OpenVSwitch Commands

* Add bridge: `ovs-vsctl add-br <bridge name>`
* Set IP on bridge: `ip addr add <IP>/<subnet number> dev <bridge name>`
* Up interface: `ip link set <bridge name> up`
* Add port: `ovs-vsctl add-port <bridge name> <port name>`
* Delete port: ` ovs-vsctl del-port <bridge name> <port name>`
* List ports on bridge: `ovs-vsctl list-ports <bridge name>`
* Set interface for IPSec: `ovs-vsctl set interface <port name> type=gre options:remote_ip=<REMOTE IP> options:psk=<PASSWORD>`
* OVS status: `/usr/share/openvswitch/scripts/ovs-ctl status`
* IPSec tunnel status: `ovs-appctl -t ovs-monitor-ipsec tunnels/show`
* Delete IP on bridge: `ip addr del <IP>/<subnet number> dev <bridge name>`
* Delete bridge: `ovs-vsctl del-br <bridge name>`

# HashiCorp Commands

* List all members: `consul members -http-addr=http://<IP>:8500`
* List all services (on server): `consul catalog services -http-addr=http://<IP>:8500`
* List all nomad servers: `nomad server members -address=http://<IP>:4646`

# Reference

* https://docs.openvswitch.org/en/latest/tutorials/ipsec/

# Notes

Those are *real* my public IP, only temporary. It's being used for testbeds and experiments.