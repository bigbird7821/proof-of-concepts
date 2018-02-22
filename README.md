Table of Contents for skeleton-chef
=================

   * [Table of Contents for skeleton](#table-of-contents-for-skeleton-skeleton)
      * [Design Highlights of the project:](#design-highlights-of-the-project)
      * [Setup instructions](#setup-instructions)


## Design Highlights of the project:
* Design decisions are documented beneath the **./doc/adr** using [Lightweight Architecture Decision Records](https://www.thoughtworks.com/radar/techniques/lightweight-architecture-decision-records), as used by Thoughtworks.
* The virtualbox base boxes beneath the **./base\_boxes** directory must be created BEFORE starting up the skeleton cluster beneath **./applications/skeleton** directory.  See the [Setup instructions](#setup-instructions) for more information. 

```
├── applications
│   └── skeleton
│       ├── environments
│       │   └── dev
│       │       ├── ansible.cfg
│       │       └── inventory
│       │           ├── aaa-group-definitions
│       │           ├── aaa-machine-definitions
│       │           ├── group_vars
│       │           ├── host_vars
│       │           └── hosts
│       ├── plays
│       │   ├── ping.yml
│       │   └── test.yml
│       ├── roles
│       └── Vagrantfile
├── base_boxes
│   ├── oel6base
│   │   ├── ansible
│   │   ├── createNewBaseBox.sh
│   │   ├── package.box
│   │   └── Vagrantfile
│   └── oel6base.skeleton
│       ├── ansible
│       ├── createNewBaseBox.sh
│       ├── package.box
│       └── Vagrantfile
├── common
│   ├── plays
│   └── roles
│       ├── common-utility-installer
│       ├── dnsmasq-configurator
│       ├── dnsmasq-installer
│       ├── epel-6.8-repository-installer
│       ├── function
│       │   └── ansible-test-runner
│       ├── proxy-configurator
│       └── vagrant-base-cleaner
├── doc
│   └── adr
│       ├── 0001-record-architecture-decisions.md
│       ├── 0002-separate-the-ansible-skeleton-application-from-the-common-ansible-roles-and-plays.md
│       ├── 0003-use-ansible-inventory-directory-with-empty-group-definitions.md
│       ├── 0004-pick-up-the-http-proxy-from-the-environment-and-inject-this-via-the-proxy-role.md
│       └── 0005-ensure-the-skeleton-application-depends-on-an-oel6-vagrant-basebox.md
└── README.md
```

## Setup instructions
* Create the vagrant base boxes beneath **./base\_boxes**:
    * Go to **./base\_boxes/oel6base**
    * vagrant up
    * Run the createNewBasebox.sh as soon as the oel6base has completed without error.  This script will create a local vagrant base box called "oel6base" that subsequent "vagrant up" actions will use.  
    * Repeat the above steps for each of the other base boxes:  **./base\_boxes/oel6base-skeleton**

* Only after the base_boxes have all been created, then 
    * Go to **./applications/skeleton**
    * vagrant up --provision

* SSH onto machine6 the ansible controller:
    * vagrant ssh machine2
    * cd /vagrant/plays
    * ansible-playbook --diff -vv ping.yml
    * ansible-playbook test.yml

    There should be no error in any of the above.  The test.yml verifies that all skeleton nodes are wired successfully together

