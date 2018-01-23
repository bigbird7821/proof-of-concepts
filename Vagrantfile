# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    config.vm.box = "insight/elk"

    # Stop the evil VirtualBox Guest Addition auto update
    config.vbguest.auto_update = false

    # Add shared roles
    config.vm.synced_folder "../../orchestration/roles", "/ansible/roles"

    # Define the number of servers
    N = 3

    # Create the current list of host definitions
    code = []
    ansible_inventory_dir = "environments/dev/inventory"
    (1..N).each do |machine_id|
        config.vm.define "machine#{machine_id}" do |machine|
            # create the inventory file
            code = ["###VAGRANT-MANAGED-BLOCK###"]
            if machine_id == N
                code << "192.168.77.#{20+machine_id} ansible_connection=local"
                code << ""
                code << "[all:vars]"
                code << "ansible_connection=ssh"
                code << "ansible_ssh_user=vagrant"
                code << "ansible_ssh_pass=vagrant"
                code << "###VAGRANT-MANAGED-BLOCK###"
            else
                code << "192.168.77.#{20+machine_id} ansible_ssh_host=192.168.77.#{20+machine_id} ansible_ssh_private_key_file=/home/vagrant/.vagrant/machines/machine#{machine_id}/virtualbox/private_key"
            end
            code.join("\n")

            # setup the ansible inventory file
            Dir.mkdir(ansible_inventory_dir) unless Dir.exist?(ansible_inventory_dir)
            File.open("#{ansible_inventory_dir}/fulllist" ,'w') do |f|
                f.write "#{code.join("\n")}\n"
            end
        end
    end

    # Provision the machines
    (1..N).each do |machine_id|
        config.vm.define "machine#{machine_id}" do |machine|
            $ipAddress = "192.168.77.#{20+machine_id}"
            $hostName = "machine#{machine_id}"

            machine.vm.hostname = "machine#{machine_id}"
            machine.vm.network "private_network", ip: "192.168.77.#{20+machine_id}"

            # Only execute once the Ansible provisioner,
            # when all the machines are up and ready.
            if machine_id == N
                # rename this host to be the ansible controller
                machine.vm.hostname = "controller"

                # ensure that all private keys are stored locally on each VM
                machine.vm.provision "shell", path: "scripts/doCopyOfSshKeys.sh"

                # ensure the ANSIBLE_CONFIG is set so that ansible-playbook can be easily run from within the controller
                machine.vm.provision "shell",
                    inline: "cd /etc/profile.d && echo \"export ANSIBLE_CONFIG=/vagrant/environments/dev\" > ansible.sh && chmod 775 ansible.sh",
                    run: "always"

                # begin the ansible provisioning...
                machine.vm.provision :ansible_local do |ansible|
                    ansible.config_file    = "environments/dev/ansible.cfg"
                    ansible.playbook       = "plays/ping.yml"
                    ansible.verbose        = "vv"
                    ansible.install        = true
                    ansible.limit          = "all" # or only "nodes" group, etc.
                    ansible.compatibility_mode	= "2.0"
                    ansible.inventory_path = "environments/dev/inventory"
                    ansible.raw_arguments  = "--diff"
                end

            end
        end
    end

end
