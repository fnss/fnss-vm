#!/bin/sh
#
# This script updates a previously created virtual machine with all latest
# version of all packages, icluding FNSS.
#
# This script requires superuser privileges.

# Variables
FNSS_VERSION='v0.6.0'
FNSS_REPO_URL='https://www.github.com/fnss/fnss'
FNSS_DIR=${HOME}/fnss
FNSS_SRC_DIR=${FNSS_DIR}/fnss-src
FNSS_DOC_DIR=${FNSS_DIR}/fnss-doc
FNSS_BIN_DIR=${FNSS_DIR}/fnss-bin

# Set echo
set -v

# Makes sure all packages installed are up-to-date
sudo apt-get update
sudo apt-get -y -q upgrade

# Install Python2 utilities and required packages
sudo pip install -U --quiet coverage autonetkit numpydoc cheesecake pylint sphinx topzootools virtualenv virtualenvwrapper

# Install Python3 utilities and required packages
# Do not install Autonetkit because it has a specific dependency on configobj=4.7.2 which is not compatibel with Python 3
sudo pip3 install -U --quiet networkx coverage numpydoc cheesecake pylint sphinx topzootools virtualenv virtualenvwrapper

# Install FNSS core library
# Install Py3 version first so that FNSS scripts are executed with Python2 by default
sudo pip3 install --quiet -U fnss
sudo pip install --quiet -U fnss

# Update FNSS source code, build doc and binaries and clean
cd ${FNSS_SRC_DIR}
# This pull may fail if there are uncommitted changes in the working directory
git pull
git checkout ${FNSS_VERSION}
make
# This operation may override doc and dist folders
mv ${FNSS_SRC_DIR}/doc ${FNSS_DOC_DIR} 
mv ${FNSS_SRC_DIR}/dist ${FNSS_BIN_DIR}
make clean
