#!/usr/bin/env bash



# create the new base box
#vagrant up --provision

# create a new package to upload
[[ -e "package.box" ]] && rm package.box
vagrant package
vagrant box add --force oel6base package.box

# clean up
#rm package.box
#rm -rf .vagrant

set +x
