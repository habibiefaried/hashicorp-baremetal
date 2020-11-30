#!/bin/bash
CONSUL_VERSION=1.9.0
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
if [ -z "${LOCAL_IP}" ]
  then
  echo "Please set LOCAL_IP env variable that will be used for config"
  exit
fi
if [ -z "${BOOTSTRAP_EXPECT}" ]
  then
  echo "Please set BOOTSTRAP_EXPECT env variable that will be used for config"
  exit
fi
apt update && apt install curl unzip -y
echo "Installing Consul..."
curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip > /tmp/consul.zip
unzip /tmp/consul.zip
install consul /usr/bin/consul
mkdir -p /etc/consul
chmod a+w /etc/consul
mkdir -p /etc/consul/data
chmod a+w /etc/consul/data
mkdir -p /etc/consul/config
chmod a+w /etc/consul/config
HOSTNAME=`hostname`
echo "Installing Dnsmasq..."
apt install dnsmasq -y
echo "Configuring Dnsmasq..."
echo "server=/consul/127.0.0.1#8600" >> /etc/dnsmasq.d/consul
echo "server=8.8.8.8" >> /etc/dnsmasq.d/consul
echo "listen-address=$LOCAL_IP" >> /etc/dnsmasq.d/consul
echo "bind-interfaces" >> /etc/dnsmasq.d/consul
echo "conf-dir=/etc/dnsmasq.d,.rpmnew,.rpmsave,.rpmorig" > /etc/dnsmasq.conf
echo "Restarting dnsmasq..."
systemctl enable dnsmasq
service dnsmasq restart
cat > /etc/consul/config/server.json <<EOF
{
  "server": true,
  "ui": true,
  "data_dir": "/opt/consul/data",
  "advertise_addr": "$LOCAL_IP",
  "client_addr": "$LOCAL_IP",
  "bootstrap_expect": $BOOTSTRAP_EXPECT
}
EOF
cat > /etc/consul/config/connect.hcl <<EOF
connect {
  enabled = true
}
ports {
  grpc = 8502
}
EOF
cat > /etc/systemd/system/consul.service <<EOF
[Unit]
Description=Consul
Requires=network-online.target
After=network-online.target

[Service]
Restart=on-failure
ExecStart=/usr/bin/consul agent -config-dir=/etc/consul/config
ExecReload=/bin/kill -HUP $MAINPID
KillSignal=SIGTERM
RestartSec=30
StartLimitBurst=5

[Install]
WantedBy=multi-user.target
EOF
systemctl enable consul
systemctl start consul
