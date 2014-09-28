#!/bin/bash
echo "==========================================="
echo "Provisioning virtual machine..."
echo "==========================================="

# Install essential packages from Apt
echo "Updating apt-get..."
apt-get update -y

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
    echo "=============================="
    echo "Installing virtualenv..."
    echo "=============================="
    pip install virtualenv virtualenvwrapper stevedore virtualenv-clone
fi

# copy the terminal settings from host
cp -rf /home/vagrant/host_resources/install/.bash_profile /home/vagrant/


#### PROJECT SETTINGS ####
PROJECT_NAME = "project_name"

#create the virtual env
mkvirtualenv $PROJECT_NAME
workon $PROJECT_NAME

# pip install apps
cd ~/www
pip install -r requirements.txt



