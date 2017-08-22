#This Script is designed to be used to setup the RPi so that all of them have the same starting point
#!/bin/bash
newHome=/home/pi/scripts
echo "Starting Script"

echo "Hi, $USER! starting network"
#networking

# install programs
echo "Hi, $USER! starting UPGRADE"
sudo apt-get update #updates OS

echo "PROGRAMMING"
#text editor GUI
sudo apt-get -y install leafpad
#text editor cmd line
sudo apt-get -y install vim 
sudo apt-get -y install espeak
#program arduinos
sudo apt-get -y install arduino
sudo apt-get install python #updates python compiler
sudo apt-get install python-serial #allows for serial monitoring
#time update
sudo apt-get -y install ntpdate #retrieves time and date informaton from internet
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
sudo apt-get install moreutils  #allows for commands that help with zip files and other
sudo apt-get install zip 

sudo apt-get install i2c-tools # enables i2c check tools
sudo apt-get install python-smbus #turns on the python bus for i2c

sudo apt-get install python-dev python-rpi.gpio #library used for GPIO controll
sudo easy_install xlsx2csv

echo "Hi, $USER! starting folder"
mkdir /home/pi/Scripts #makes central folder for repositories
cd /home/pi/Scripts

git clone https://github.com/anthonylamme/RaspberryPIScripts.git #general use scripts containing startup,update and git update
git clone https://github.com/anthonylamme/Pick2Light.git #Pick2Light project programs
git clone https://github.com/anthonylamme/RoboticArmCode.git #robotic arm code 
git clone https://github.com/anthonylamme/Scanner.git

wget https://raw.githubusercontent.com/tbird20d/grabserial/master/grabserial grabserial  #serial reader/writer for data collection
sudo echo "echo "Loading starting programs"" >> /home/pi/.bashrc
sudo echo "sudo bash /home/pi/Scripts/RaspberryPIScripts/UpdateGit.bash" >> /home/pi/.bashrc #places updategit to start at start up

echo "Which Project do you want to run?"
select pr in "RobotArm" "Pick2Light" "Standard" "Scanner"; do
    case $pr in
      RobotArm) 
        echo "Be the Arm"
        break;; 
      Pick2Light) 
        
	echo "Pick the Light" #creates token folder and data folder for use with slackclient and data collection
	cd /home/pi/P2LightData
	cd /home/pi/P2LightData/Tokens
	cd /home/pi/P2LightData/Data
	cd /home/pi/P2LightData/JSONData

	sudo echo "sudo bash /home/pi/Scripts/Pick2Light/RaspberryPiCode/Pick2Light.bash" >> /home/pi/.bashrc #allows Pick2Light to run at start u
        sudo echo "sudo bash /home/pi/Scripts/RaspberryPIScripts/SlackBot/Slack.bash" >> /home/pi/.bashrc #allows for Slack Bot to run at start up

	break;;
      Standard) 
	echo "Get the Scrap"
	sudo echo "sudo bash /home/pi/Scripts/RaspberryPIScripts/SlackBot/Slack.bash" >> /home/pi/.bashrc #slackbot start up bash
	break;;
      Scanner)
    	echo "Scanner for hire"
    	sudo echo "sudo bash /home/pi/Scripts/RaspberryPIScripts/SlackBot/Slack.bash" >> /home/pi/.bashrc #slackbot start up bash
    	sudo echo "sudo bash /home/pi/Scripts/Scanner/Scanner.bash" >> /home/pi/.bashrc #slackbot start up bash
	break;;
    esac
done

echo "Finished"
sudo reboot #reboots to finalize installs
