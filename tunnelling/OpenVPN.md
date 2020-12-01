# OpenVPN Reference
* Using this one: https://github.com/angristan/openvpn-install
* Open file `/etc/openvpn/server.conf` and comment `redirect-gateway def1 bypass-dhcp`. Restart the openvpn
* Issue the command `echo "ifconfig-push 10.8.0.3 255.255.255.0" > /etc/openvpn/ccd/user03` if you want `user03` having static IP `10.8.0.3`
* Copy the ovpn file content to `/etc/openvpn/client.conf`
* `systemctl enable openvpn@client.service` and `service openvpn@client start` to start that ovpn on client nodes.