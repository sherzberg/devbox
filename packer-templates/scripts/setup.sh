#!/bin/bash

apt-get update -qq

apt-get install -y linux-image-extra-$(uname -r)
apt-get install -y apt-transport-https ca-certificates
apt-get install -y build-essential libssl-dev
apt-get install -y cowsay haveged
apt-get install -y htop
apt-get install -y software-properties-common


echo "Setup dev utilities"
echo "==================="
sudo apt-add-repository ppa:git-core/ppa
apt-get update
apt-get install -y git mercurial
curl -s https://s3.amazonaws.com/download.draios.com/stable/install-sysdig | bash


echo "Setup nodejs"
echo "==================="
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
apt-get install -y nodejs
npm install -g bower
npm install -g ember-cli


echo "Setup python"
echo "==================="
apt-get install -y python-dev python3-dev python-pip 
pip install autoenv virtualenvwrapper


echo "Setup php"
echo "==================="
apt-get install -y php5-dev php5-curl php5-mcrypt php5-mysql


echo "Setup go"
echo "==================="
wget https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.6.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" > /etc/profile.d/golang.sh


echo "Setup vim"
echo "==================="
apt-get install -y vim-nox

echo "Setup neovim"
echo "==================="
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim


echo "Setup docker"
echo "==================="
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
apt-get update -qq
apt-get install -y docker-engine
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

apt-get autoremove -y
apt-get clean
