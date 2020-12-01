# hashicorp-baremetal

Hashicorp stack on baremetal deployment

# Spec

* 3 VPS S SSD servers on contabo.com (public IP only)
* Usage:
  *	161.97.158.37, for consul server
  *	161.97.158.38, for nomad server, with consul client
  * 161.97.158.40, for nomad client, with consul client
  
* OS: Debian 10

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