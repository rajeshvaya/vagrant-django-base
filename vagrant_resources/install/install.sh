#!/bin/bash
echo "==========================================="
echo "Provisioning virtual machine..."
echo "==========================================="

# Install essential packages from Apt
echo "Updating apt-get..."
#apt-get update -y

# python-setuptools
echo "=============================="
echo "Installing python-setuptools"
echo "=============================="
apt-get install python-setuptools -y

#apache
if ! command -v apache2; then
    echo "=============================="
    echo "Installing Apache2"
    echo "=============================="
    sudo apt-get install apache2 -y
fi

#git
if ! command -v git; then
    echo "=============================="
    echo "Installing Git"
    echo "=============================="
    sudo apt-get install git -y
fi


#mysql
if ! command -v mysql; then
    echo "=============================="
    echo "Setting up MySQL..."
    echo "=============================="
    apt-get install debconf-utils -y
    debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
    debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

    apt-get install python-dev -y
    apt-get install libmysqlclient-dev -y
fi

# pip
if ! command -v pip; then
    echo "=============================="
    echo "Installing pip..."
    echo "=============================="
    easy_install -U pip
fi

#virtualenv
if [[ ! -f /usr/local/bin/virtualenv ]]; then
    echo "==========================================="
    echo "Installing virtualenv virtualwrapper..."
    echo "==========================================="
    pip install virtualenv virtualenvwrapper stevedore virtualenv-clone
fi

echo "================================="
echo "Setting up .bash_profile"
echo "================================="
# copy the terminal settings from host
cp -rf /home/vagrant/host_resources/install/.bash_profile /home/vagrant/
source /home/vagrant/.bash_profile


#### PROJECT SETTINGS ####
ENV_NAME="default"


echo "================================="
echo "Creating virtual environments"
echo "================================="

#create the virtual env
mkvirtualenv $ENV_NAME;
workon $ENV_NAME;

echo "============================================="
echo "Install default apps as per requirements.txt"
echo "============================================="
# pip install apps
cd /home/vagrant/www/;
pip install -r requirements.txt



