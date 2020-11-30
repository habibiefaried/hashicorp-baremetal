# hashicorp-baremetal

Hashicorp stack on baremetal deployment

# Spec

* 3 VPS S SSD servers on contabo.com (public IP only)
* We are using 192.168.1.0/24 for our private networking. With mapping:
  * 161.97.158.40 with 10.8.0.3, for nomad client, with consul client
  *	161.97.158.38 with 10.8.0.2, for nomad server, with consul client
  *	161.97.158.37 with 10.8.0.1, for consul server only with OpenVPN server
* OS: Debian 10

# HashiCorp Commands

* List all members: `consul members -http-addr=http://<IP>:8500`
* List all services (on server): `consul catalog services -http-addr=http://<IP>:8500`
* List all nomad servers: `nomad server members -address=http://<IP>:4646`

# OpenVPN Reference

* Using this one: https://github.com/angristan/openvpn-install
* Open file `/etc/openvpn/server.conf` and comment `redirect-gateway def1 bypass-dhcp`. Restart the openvpn
* Issue the command `echo "ifconfig-push 10.8.0.50 255.255.255.0" > /etc/openvpn/ccd/user03` if you want `user03` having static IP `10.8.0.50`
* Copy the `.ovpn` to `/etc/openvpn` and rename it to `client.conf` on ovpn client nodes.
* `systemctl enable openvpn@client.service` and `service openvpn@client start` to start that ovpn on client nodes.

# Notes

* Those are *real* my public IP, only temporary. It's being used for testbeds and experiments.
* set `net.ipv4.ip_forward = 1`
* BUG: I have to stop the job, before run the updated job. Otherwise, reserved_port error