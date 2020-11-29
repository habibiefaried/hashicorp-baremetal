# hashicorp-baremetal
Hashicorp stack on baremetal deployment

# Spec
* 3 VPS S SSD servers on contabo.com (public IP only)
* We are using 192.168.1.0/24 for our private networking. 1.1, 1.2, 1.3 is being used for each of those hosts respectively.
* IPSec PSK: `swordF1sh`

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

# Reference
* https://docs.openvswitch.org/en/latest/tutorials/ipsec/