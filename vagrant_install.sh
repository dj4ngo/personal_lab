#!/bin/bash

set -e

##### Functions

function install_deps () {
	echo "--> update apt cache"
	sudo apt update -qqq
	echo "--> build-dep vagrant"
	sudo apt-get build-dep -y vagrant ruby-libvirt
	echo "--> install libvirt"
	sudo apt-get install -y qemu libvirt-bin ebtables dnsmasq wget
	sudo apt-get install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
}


function install_vagrant () {
	echo "--> get Vagrant"
	if dpkg -l vagrant &>/dev/null; then 
		echo "# Vagrant is already installed, do not install it"
	else	
		wget https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.deb
		sudo dpkg -i vagrant_2.0.0_x86_64.deb
		rm vagrant_2.0.0_x86_64.deb
	fi
}


function install_vagrant_plugin () {
	vplugin="${1}"

	echo "--> install ${vplugin} plugin"
	if vagrant plugin list | grep -q "^${vplugin}\>"; then
		echo "# Vagrant plugin ${vplugin} already installed !"
	else
		vagrant plugin install ${vplugin}
	fi
}



###### Main

echo "## Install  Vagrant "
install_deps
install_vagrant

install_vagrant_plugin vagrant-libvirt
install_vagrant_plugin vagrant-scp

echo "### Install Vagrant DONE"

