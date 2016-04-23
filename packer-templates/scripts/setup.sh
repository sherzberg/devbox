#!/bin/bash

apt-get update -qq

apt-get install -y build-essential libssl-dev
apt-get install -y cowsay haveged


echo "Setup dev utilities"
echo "==================="
apt-get install -y git mercurial


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


echo "Setup vim"
echo "==================="
apt-get install -y vim-nox
