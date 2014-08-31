# FNSS Virtual Machine

This repository contains scripts and tools to create a Ubuntu virtual machine with the entire FNSS toolchain installed and ready to use.
Such a virtual machine may be used for several reasons, such as:

 * Try out FNSS without having to install it and all its dependencies on your machine
 * Run FNSS in the cloud
 * For educational purposes

It is possible to create this virtual machine in two ways: manually or using [Vagrant](http://www.vagrantup.com).

## Create a virtual machine manually
First of all you need to create a new virtual machine with Ubuntu 14.04. To do so, create the virtual machine using your chosen hypervisor (e.g. VirtualBox, VMware Desktop, etc..) and install Ubuntu 14.04 on it.
Once the Ubuntu installation is completed, make sure you have a working Internet connection.
Then open a terminal and type the following command:

    $ wget --no-check-certificate https://raw.githubusercontent.com/fnss/fnss-vm/master/setup.sh -O - | sh

This command will download and execute [this script](https://github.com/fnss/fnss-vm/blob/master/setup.sh).
It will take care of downloading and installing the latest version of FNSS alongside all its dependencies.

## Create a virtual machine with Vagrant
You can create a virtual machine more easily using [Vagrant](http://www.vagrantup.com). To do so, you must first download and install Vagrant from its website and ensure you have at least one so called *provider* (i.e. a hypervisor supported by Vagrant) installed, e.g. VirtualBox.
If this is the first time you use Vagrant or you have never used it to create Ubuntu 14.04 based virtual machines, you need to ensure you have the Ubuntu 14.04 box installed. To do so, open a command shell and type:

    $ vagrant box add chef/ubuntu-14.04

This will download a Ubuntu 14.04 blueprint virtual machine.

Now, from the shell move to the directory where this file is located, which also contains the file `Vagrantfile` and type:

    $ vagrant up

This command will create a virtual machine, boot it up and install all required dependencies using the configuration information contained in `Vagrantfile`.

Now you can SSH to the virtual machine with:

    $ vagrant ssh

To shut down the virtual machine simply exit from the SSH session and type:

    $ vagrant halt

## Recommended VM configuration
This section lists a set of recommended configuration parameters although not all are required:
 * Hypervisor: Oracale VirtualBox 4.3.12
 * Guest OS: Ubuntu 14.04 (Desktop/Server)
 * RAM: 1024+ MB
 * HD: 10+ GB
 * HD format: VMDK (for easier export to OVF format)
