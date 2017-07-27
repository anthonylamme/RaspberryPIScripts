#!/bin/bash
newHome=/home/pi/Scripts

echo "Updating Pi"

sudo apt-get update

#text editor GUI
sudo apt-get -y install leafpad
#text editor cmd line
sudo apt-get -y install vim 
sudo apt-get -y install espeak
#program arduinos
sudo apt-get -y install arduino
sudo apt-get install python
sudo apt-get install python-serial
#time update
sudo apt-get -y install ntpdate 
#possible use later for cluster monitoring
sudo apt-get -y install nodejs 
#Server side programs
sudo apt-get -y install apache2 apache2-doc apache2-utils
sudo apt-get -y install libapache2-mod-php5 php5 php-pear php5-xcache
sudo apt-get -y install php5-mysql
sudo apt-get install mysql-server mysql-client
#tool for ssh
sudo apt-get -y install screen -y
#slack interface
sudo pip install slackclient
#cmdline tool
sudo apt-get install moreutils

cd /home/pi/Scripts/Pick2Light
git pull
cd /home/pi/Scripts/RaspberryPIScripts
git pull
cd /home/pi/Scripts/RoboticArmCode
git pull

echo "finished"