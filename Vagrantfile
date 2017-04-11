# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/centos-6.8"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL



  # Copy files from my host (Windows) to the guest (vagrant)
  #config.vm.provision "file", source: "~/.vimrc", destination: ".vimrc"
  #config.vm.provision "shell", inline: "mkdir -p ~/.vim/bundle"
  #config.vm.provision "file", source: "~/.vim", destination: ".vim"
  #config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"

  # Do stuff with an inline bash script
  $script = <<-EOF
    # comment the following if you want to run bash commands first
    #/bin/bash /vagrant/provision/bootstrap.sh
    #sudo yum install -y vim
    mkdir -p ~/.vim/bundle
    echo "This is an inline ansible bash script"
    EOF
  #config.vm.provision "shell", inline: $script

  # set (OR unset) the vagrant proxy depending on current environment variable settings
  config.proxy.http = ENV['http_proxy'] || ''
  config.proxy.https = ENV['http_proxy'] || ''
  config.proxy.no_proxy = ENV['no_proxy'] || ''

  N = 5
  (1..N).each do |machine_id|
	config.vm.define "node#{machine_id}" do |machine|
	  machine.vm.hostname = "node#{machine_id}"
	  machine.vm.network "private_network", ip: "172.17.177.#{20+machine_id}"
      machine.vbguest.auto_update = true
	  machine.vm.provision "shell", inline: $script
	end
  end

  # setup a port forward to the web node
  #config.vm.define 'node1' do |machine|
  #  machine.vm.network "forwarded_port", guest: 80, host: 8080
  #end

  config.vm.define 'controller' do |machine|
    machine.vm.network "private_network", ip: "172.17.177.11"
    machine.vbguest.auto_update = true

    # get the password file to decrypt ansible-vault sensitive data
    machine.vm.provision "file", source: "~/dotfiles/.vault/lamp_simple.password", destination: "/home/vagrant/vpass"
    machine.vm.provision "shell", inline: "chmod 0640 /home/vagrant/vpass"

    machine.vm.provision :ansible_local do |ansible|
      ansible.config_file    = "plays/ansible.cfg"
      ansible.playbook       = "site.yml"
      ansible.verbose        = "vv"
      ansible.install        = true
      ansible.limit          = "all" # or only "nodes" group, etc.
      ansible.inventory_path = "development.ini"
      #ansible.raw_arguments  = "--ask-vault-pass"
      ansible.vault_password_file = "/home/vagrant/vpass"
    end

  end
  
end
