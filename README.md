# hashicorp-baremetal

Hashicorp stack on baremetal deployment

# Spec

* 3 VPS S SSD servers on contabo.com (public IP only)
* Usage:
  *	161.97.158.37 with 10.8.0.1, for consul server
  *	161.97.158.38 with 10.8.0.2, for nomad server, with consul client
  * 161.97.158.40 with 10.8.0.3, for nomad client, with consul client
  
* OS: Debian 10

# OpenVPN Reference
* Using this one: https://github.com/angristan/openvpn-install
* Open file `/etc/openvpn/server.conf` and comment `redirect-gateway def1 bypass-dhcp`. Restart the openvpn
* Issue the command `echo "ifconfig-push 10.8.0.3 255.255.255.0" > /etc/openvpn/ccd/user03` if you want `user03` having static IP `10.8.0.3`
* Copy the ovpn file content to `/etc/openvpn/client.conf`
* `systemctl enable openvpn@client.service` and `service openvpn@client start` to start that ovpn on client nodes.

# HashiCorp Commands

* List all members: `consul members`
* List all services (on server): `consul catalog services`
* List all nomad servers: `nomad server members`
* Consul raft: `consul operator raft list-peers`
* Nomad raft: `nomad operator raft list-peers`

# Notes

* Those are *real* my public IP, only temporary. It's being used for testbeds and experiments.
* Generate key for nomad and consul: `openssl rand -base64 32`. On this script, change every key on `encrypt` section of config
* WARNING: Cannot run job when `encrypt` is set