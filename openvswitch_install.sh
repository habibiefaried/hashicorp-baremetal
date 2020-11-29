#!/bin/bash
apt update 
apt install dkms strongswan build-essential fakeroot -y # Build
wget https://www.openvswitch.org/releases/openvswitch-2.14.0.tar.gz
tar -xvf openvswitch-2.14.0.tar.gz
apt install graphviz autoconf automake1.10 bzip2 debhelper dh-autoreconf libssl-dev libtool openssl procps python3-all python3-sphinx python3-twisted python3-zope.interface libunbound-dev libunwind-dev -y # Build Depends on this version
apt install iproute2 python3-openvswitch -y # For openvswitch
cd openvswitch-2.14.0
dpkg-checkbuilddeps
automake --add-missing
DEB_BUILD_OPTIONS='parallel=8' fakeroot debian/rules binary
