# FNSS Virtual Machine

This repository contains scripts and tools to create a Ubuntu virtual machine with the entire FNSS toolchain installed and ready to use.
Such a virtual machine may be used for several reasons, such as:

 * Try out FNSS without bothering installing it and all its dependencies on your machine
 * To run FNSS in the cloud
 * For educational purposes

## How to make a VM?
First of all you need to create a new virtual machine with Ubuntu 14.04. 
Once the Ubuntu installation is completed, make sure you have a working Internet connection.
Then open a command terminal and type the following command:

    $ wget --no-check-certificate https://raw.githubusercontent.com/fnss/fnss-vm/master/setup.sh -O - | sh

This command will download and execute [this script](https://github.com/fnss/fnss-vm/blob/master/setup.sh).
It will take care of downloading and installing the latest version of FNSS alongside all its dependencies.

# Recommended VM configuration
This section lists a set of recommended configuration parameters although not all are required:
 * Hypervisor: Oracale VirtualBox 4.3.12
 * Guest OS: Ubuntu 14.04 (Desktop/Server)
 * RAM: 1024+ MB
 * HD: 10+ GB
 * HD format: VMDK (for easier export to OVF format)