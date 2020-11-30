# hashicorp-baremetal

Hashicorp stack on baremetal deployment

# Spec

* 3 VPS S SSD servers on contabo.com (public IP only)
* We are using 192.168.1.0/24 for our private networking. With mapping:
  * 161.97.158.40 with 192.168.1.1, for nomad client, with consul client
  *	161.97.158.38 with 192.168.1.2, for nomad server, with consul client
  *	161.97.158.37 with 192.168.1.3, for consul server only with OpenVPN server
* OS: Debian 10

# HashiCorp Commands

* List all members: `consul members -http-addr=http://<IP>:8500`
* List all services (on server): `consul catalog services -http-addr=http://<IP>:8500`
* List all nomad servers: `nomad server members -address=http://<IP>:4646`

# Reference

* https://linuxconfig.org/basic-ubuntu-20-04-openvpn-client-server-connection-setup

# Notes

* Those are *real* my public IP, only temporary. It's being used for testbeds and experiments.