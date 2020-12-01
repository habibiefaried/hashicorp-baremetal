# hashicorp-baremetal

Hashicorp stack on baremetal deployment

# Spec

* 3 VPS S SSD servers on contabo.com (public IP only)
* Usage:
  * 161.97.158.40, for nomad client, with consul client
  *	161.97.158.38, for nomad server, with consul client
  *	161.97.158.37, for consul server
* OS: Debian 10

# HashiCorp Commands

* List all members: `consul members`
* List all services (on server): `consul catalog services`
* List all nomad servers: `nomad server members`

# Notes

* Those are *real* my public IP, only temporary. It's being used for testbeds and experiments.
