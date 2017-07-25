#!/bin/bash
newHome=/home/pi/scripts
echo "Starting Script"

echo "Hi, $USER! starting network"
#networking


# install programs
echo "Hi, $USER! starting UPGRADE"

sudo apt-get update

echo "PROGRAMMING"
sudo apt-get -y install leafpad
sudo apt-get -y install vim
sudo apt-get -y install espeak
sudo apt-get -y install arduino
sudo apt-get -y install ntpdate
sudo apt-get -y install nodejs
sudo apt-get -y install apache2 apache2-doc apache2-utils
sudo apt-get -y install libapache2-mod-php5 php5 php-pear php5-xcache
sudo apt-get -y install php5-mysql
sudo apt-get install mysql-server mysql-client
sudo apt-get -y install screen -y
sudo pip install slackclient

echo "Hi, $USER! starting folder"
mkdir /home/pi/Scripts
cd /home/pi/Scripts

git clone https://github.com/anthonylamme//RaspberryPIScripts.git
git clone https://github.com/anthonylamme/Pick2Light.git
git clone https://github.com/anthonylamme/RoboticArmCode.git

echo "Finished"
sudo reboot
