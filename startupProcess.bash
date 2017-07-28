#!/bin/bash
newHome=/home/pi/scripts
echo "Starting Script"

echo "Hi, $USER! starting network"
#networking

# install programs
echo "Hi, $USER! starting UPGRADE"
sudo apt-get update

echo "PROGRAMMING"
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
sudo apt-get install zip

sudo apt-get install i2c-tools
sudo apt-get install python-smbus

sudo apt-get install python-dev python-rpi.gpio

echo "Hi, $USER! starting folder"
mkdir /home/pi/Scripts
cd /home/pi/Scripts

git clone https://github.com/anthonylamme/RaspberryPIScripts.git
git clone https://github.com/anthonylamme/Pick2Light.git
git clone https://github.com/anthonylamme/RoboticArmCode.git
wget https://raw.githubusercontent.com/tbird20d/grabserial/master/grabserial grabserial
sudo echo "echo "Loading starting programs"" >> /home/pi/.bashrc
sudo echo "sudo bash /home/pi/Scripts/RaspberryPIScripts/UpdateGit.bash" >> /home/pi/.bashrc

echo "Which Project do you want to run?"
select pr in "RobotArm" "Pick2Light" "Standard"; do
    case $pr in
      RobotArm) 
        echo "Be the Arm"
        break;; 
      Pick2Light) 
        
	echo "Pick the Light"
	cd /home/pi/P2LightData
	cd /home/pi/P2LightData/Tokens
	cd /home/pi/P2LightData/Data

	sudo echo "sudo bash /home/pi/Scripts/Pick2Light/RaspberryPiCode/Pick2Light.bash" >> /home/pi/.bashrc
        sudo echo "sudo bash /home/pi/Scripts/SlackBot/Slack.bash" >> /home/pi/.bashrc

	break;;
      Standard) 
	echo "Get the Scrap"
	sudo echo "sudo bash /home/pi/Scripts/SlackBot/Slack.bash" >> /home/pi/.bashrc
	break;;
    esac
done

echo "Finished"
sudo reboot