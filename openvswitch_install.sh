#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
VERSION=2.14.0
echo "Installing dependencies..."
apt update
apt install dkms build-essential fakeroot iproute2 -y # Common build
apt install graphviz autoconf automake1.10 bzip2 debhelper dh-autoreconf libssl-dev libtool openssl procps python3-all python3-sphinx python3-twisted python3-zope.interface libunbound-dev libunwind-dev -y # Build depends on this version
echo "Downloading source..."
wget https://www.openvswitch.org/releases/openvswitch-$VERSION.tar.gz && tar -xvf openvswitch-$VERSION.tar.gz && cd openvswitch-$VERSION
echo "Check and compiling..."
dpkg-checkbuilddeps
automake --add-missing
DEB_BUILD_OPTIONS='parallel=8 nocheck' fakeroot debian/rules binary
cd ..
echo "Installing..."
dpkg -i libopenvswitch_*.deb openvswitch-common_*.deb openvswitch-switch_*.deb openvswitch-datapath-dkms_*.deb python3-openvswitch_*.deb openvswitch-pki_*.deb openvswitch-ipsec_*.deb || true
apt install -f -y
/usr/share/openvswitch/scripts/ovs-ctl start
/usr/share/openvswitch/scripts/ovs-ctl status
