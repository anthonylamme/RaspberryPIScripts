#!/bin/bash
newHome=/home/pi/scripts
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
mkdir /home/pi/Scripts
cd /home/pi/Scripts

sudo git clone https://github.com/anthonylamme/RaspberryPIScripts
sudo git clone https://github.com/anthonylamme/Pick2Light
sudo git clone https://github.com/anthonylamme/RoboticArmCode
~
~
~
echo "Finished"
sleep 20
sudo reboot
