#!/bin/bash
newHome=/home/pi/scripts
url1=https://github.com/anthonylamme/RaspberryPIScripts
url2=https://github.com/anthonylamme/Pick2Light
url3=https://github.com/anthonylamme/RoboticArmCode
echo "Starting Script"

echo "Hi, $USER! starting network"
#networking


# install programs
echo "Hi, $USER! starting install"
sudo apt-get -y install leafpad
sudo apt-get -y install vim
sudo apt-get -y install espeak
sudo apt-get -y install arduino
sudo apt-get -y install ntpdate
sudo apt-get -y install nodejs

echo "Hi, $USER! starting folder"
mkdir Scripts
cd Scripts

sudo git clone url1
sudo git clone url2
sudo git clone url3
~
~
~
echo "Finished"
sleep 20
sudo reboot
