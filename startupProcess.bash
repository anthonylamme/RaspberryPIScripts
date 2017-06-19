#!/bin/bash
newHome=/home/pi/scripts
url1=git@github.com:anthonylamme/Pick2Light.git
url2=git@github.com:anthonylamme/RoboticArmCode.git
echo "Starting Script"

echo "Hi, $USER! starting network"
#networking


# install programs
echo "Hi, $USER! starting install"
sudo apt-get -y install leafpad
sudo apt-get -y install vim
sudo apt-get -y install arduino
sudo apt-get -y install ntpdate
sudo apt-get -y install nodejs
sudo git clone url1
sudo git clone url2
~
~
~
echo "Finished"
sleep 20
sudo reboot
