#!/usr/bin/env bash

##############################################################################
# Functions
##############################################################################
function cleanupTheVmBeforeCreatingNewVagrantBase(){
	# Uncomment the following if you want the basebox to be proxy agnostic
	# sudo rm /etc/profile.d/proxy.sh

	# ensure the base VM is as 'light' as possible
	sudo yum clean all -y
	sudo dd if=/dev/zero of=/EMPTY bs=1M
	sudo rm -rf /EMPTY
	sudo cat /dev/null > ~/.bash_history && history -c
	sudo rm -rf /etc/sysconfig/network-scripts/ifcfg-eth1
	sudo rm -rf /etc/udev/rules.d/70-persistent-net.rules
}

##############################################################################
# Main
##############################################################################

set -x

cleanupTheVmBeforeCreatingNewVagrantBase

set +x
