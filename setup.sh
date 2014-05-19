#!/bin/sh
#
# This script downloads and install on a clean Ubuntu 14.04 installation everything required to have FNSS operational along with additional useful packages. 
#
# This script requires superuser privileges.
#
FNSS_VERSION='v0.5.0'
FNSS_REPO_URL='https://www.github.com/fnss/fnss'
FNSS_SRC_DIR=${HOME}/fnss-src
FNSS_DOC_DIR=${HOME}/fnss-doc
FNSS_BIN_DIR=${HOME}/fnss-bin

# TODO: Notes
# I need to configure one NAT and one host-only interface 
# I may need to do post-download stuff 
# http://www.brianlinkletter.com/set-up-mininet/
# https://github.com/mininet/openflow-tutorial/wiki/Set-up-Virtual-Machine
# http://mininet.org/vm-setup-notes/

# Makes sure all packages installed are up-to-date
sudo apt-get update
sudo apt-get  -y -q upgrade

# Install generic utilities
sudo apt-get install zsh curl mtr traceroute tcptraceroute htop screen vim vim-runtime

curl -L http://install.ohmyz.sh | sh

# Install Python2 utilities and required packages
sudo apt-get -y -q install python ipython python-pip python-setuptools cython ipython-notebook ipython-qtconsole
sudo apt-get -y -q install python-dev python-scipy python-numpy python-matplotlib python-networkx python-gnuplot python-mako python-nose
sudo pip install -U --quiet coverage autonetkit numpydoc cheesecake pylint sphinx topzootools virtualenv virtualenvwrapper

# Install Python3 utilities and required packages
sudo apt-get -y -q install python3 ipython3 python3-pip python3-setuptools cython3 ipython3-notebook ipython3-qtconsole
sudo apt-get -y -q install python3-dev python3-scipy python3-numpy python3-matplotlib python3-gnuplot python3-mako python3-nose
sudo pip3 install -U --quiet networkx coverage autonetkit numpydoc cheesecake pylint sphinx topzootools virtualenv virtualenvwrapper

# Install FNSS core library
sudo pip install --quiet fnss
sudo pip3 install --quiet fnss

# Install Mininet
sudo apt-get -y -q install mininet
sudo service openvswitch-controller stop
sudo update-rc.d openvswitch-controller disable

# Test Mininet:
sudo mn --test pingall

# Install Java API requirements
sudo apt-get -y -q install default-jdk default-jre ant

# Install C++ API requirements
sudo apt-get -y -q install doxygen

# Install Git
sudo apt-get -y -q install git 

# Install Eclipse
sudo apt-get -y -q install eclipse eclipse-cdt

# Get FNSS source code, build doc and binaries and clean
git clone ${FNSS_REPO_URL} ${FNSS_DIR}
cd ${FNSS_SRC_DIR}
git checkout ${FNSS_VERSION}
make
mv ${FNSS_SRC_DIR}/doc ${FNSS_DOC_DIR} 
mv ${FNSS_SRC_DIR}/dist ${FNSS_BIN_DIR}
make clean

# Install ns-3 prerequisites
# prerequisites
# sudo apt-get install gcc g++ python python-dev mercurial bzr gdb valgrind gsl-bin \
#  libgsl0-dev libgsl0ldbl tcpdump flex bison sqlite sqlite3 libsqlite3-dev libxml2 libxml2-dev \ 
#  libgtk2.0-0 libgtk2.0-dev doxygen graphviz imagemagick \
#  python-pygraphviz python-kiwi python-pygoocanvas libgoocanvas-dev \ 
#  libboost-signals-dev libboost-filesystem-dev \
#  uncrustify vtun lxc \
#  openmpi-bin openmpi-common openmpi-doc libopenmpi-dev \ 
#  gcc-multilib

# To install ns-3 follow the instructions at: http://www.nsnam.org/wiki/index.php/Installation

# Install VirtualBox guest additions
# sudo apt-het -y -q install virtualbox-guest-additions-iso