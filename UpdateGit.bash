#This Script will update the RPi every time it turns on or is Commanded to by Slack

#!/bin/bash
newHome=/home/pi/Scripts

echo "Updating Pi"

sudo apt-get update #update OS

cd /home/pi/Scripts/Scanner
git pull
cd /home/pi/Scripts/Pick2Light #change to Pick2Light folder
git pull #pulls recent version from gitHub
cd /home/pi/Scripts/RaspberryPIScripts #change to Rasberry PI Script folder
git pull #pulls recent version from gitHub
cd /home/pi/Scripts/RoboticArmCode #change to Robotic Arm Code folder
git pull #pulls recent version from gitHub
cd /home/pi/Scripts/RaspberryPIScripts
git pull

echo "finished at last"
