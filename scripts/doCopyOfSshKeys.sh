#!/usr/bin/env bash

# ensure that rsync is installed first
which rsync
if [ $? != 0 ]; then
  echo "installing rsync"
  sudo yum install -y rsync
else
  echo "rsync already installed."
fi

# get the list of vagrant-created (insecure) private keys
(
	cd /vagrant
	list=$(find .vagrant -type f -name "*private*")

	# rsync the vagrant keys beneath /home/vagrant and chmod 600
	TARGET="/home/vagrant"
	if [[ ! -d "${TARGET}" ]]; then mkdir -p "${TARGET}"; fi
	for FILE in ${list}; do
	   echo "[${FILE}]"
	   sudo rsync -avR ${FILE} ${TARGET}
	   sudo chmod 600 "${TARGET}/${FILE}"
	done

	# confirm that the keys are the correct permissions
	sudo find ${TARGET}/.vagrant -type f -exec namei -mo {} \;
)
