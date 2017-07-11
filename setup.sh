#!/bin/sh
#
# This script downloads and installs on a clean Ubuntu 16.04 installation everything
# required to have FNSS operational along with additional useful packages.
# This script requires superuser privileges.

# Set echo
set -v

# Move to HOME folder
cd ${HOME}

# This is to avoid the following warning to show up when running apt-get
# dpkg-reconfigure: unable to re-open stdin: No file or directory
export DEBIAN_FRONTEND=noninteractive

export APT_GET="sudo -E apt-get -y -qq "
# Make sure all packages installed are up-to-date
$APT_GET update

# Install Git
$APT_GET install git

# Install core library requirements
$APT_GET install python python-pip python-dev
$APT_GET install libatlas-dev libatlas-base-dev liblapack-dev gfortran libsuitesparse-dev libgdal-dev graphviz mono-devel

# Install Java API requirements
$APT_GET install default-jdk default-jre ant

# Install C++ API requirements
$APT_GET install doxygen clang

# Install Mininet
# Notes:
# A user may want to configure one NAT and one host-only interface so that it can SSH
# to the VM from the host OS, like it is done with Mininet:
#  * http://www.brianlinkletter.com/set-up-mininet/
#  * https://github.com/mininet/openflow-tutorial/wiki/Set-up-Virtual-Machine
#  * http://mininet.org/vm-setup-notes/
$APT_GET install mininet

# Clone all repos
git clone https://github.com/fnss/fnss.git
git clone https://github.com/fnss/fnss-java.git
git clone https://github.com/fnss/fnss-cpp.git
git clone https://github.com/fnss/fnss-ns3.git

# Build all repos
# The -H flag allows pip to cache wheels
sudo -H make -C fnss install
make -C fnss-cpp
sudo make -C fnss-cpp install
ant -f fnss-java

# This script does not install ns-3
# To install ns-3 and configure it with usage with FNSS, follow these steps:
# 1. Download or clone ns-3 codebase
# 2. Copy FNSS ns-3 adapter into ns-3 tree with:
#    $ make -C fnss-ns3 install NS3_DIR=/path/to/ns3/dir/
# 3. Build ns-3 following the instructions at: https://www.nsnam.org/wiki/Installation
