#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
VERSION=2.14.0
echo "Installing dependencies..."
apt update
apt install git dkms strongswan build-essential fakeroot iproute2 -y # Common build
apt install graphviz autoconf automake1.10 bzip2 debhelper dh-autoreconf libssl-dev libtool openssl procps python3-all python3-sphinx python3-twisted python3-zope.interface libunbound-dev libunwind-dev -y # Build depends on this version
echo "Downloading source..."
# git clone https://github.com/openvswitch/ovs && cd ovs && git checkout v2.14.0
wget https://www.openvswitch.org/releases/openvswitch-$VERSION.tar.gz && tar -xvf openvswitch-$VERSION.tar.gz && cd openvswitch-$VERSION
echo "Check and compiling..."
dpkg-checkbuilddeps
automake --add-missing
DEB_BUILD_OPTIONS='parallel=8' fakeroot debian/rules binary
cd ..
ls -lah | grep .deb
echo "Installing..."
dpkg -i *.deb || true
apt install -f -y
/usr/share/openvswitch/scripts/ovs-ctl start
/usr/share/openvswitch/scripts/ovs-ctl status
sysctl -w net.ipv4.ip_forward=1 # Make this permanent by edit /etc/sysctl.conf