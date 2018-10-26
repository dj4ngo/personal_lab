#!/bin/bash

set -e
set -x

echo "## Install  Vagrant "
sudo apt update
sudo apt-get build-dep -y vagrant ruby-libvirt

echo "--> install libvirt"
sudo apt-get install -y qemu libvirt-bin ebtables dnsmasq wget
sudo apt-get install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev

echo "--> get Vagrant"
wget https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.deb
sudo dpkg -i vagrant_2.0.0_x86_64.deb

echo "--> install vagrant-libvirt plugin"
rm vagrant_2.0.0_x86_64.deb
vagrant plugin install vagrant-libvirt
echo "### Install Vagrant DONE"

