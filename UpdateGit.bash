#!/bin/bash
# Update the Raspberry Pi on reboot or when commanded to by Slack

echo "Syncing local project repositories with remote..."

cd /home/pi/Scripts/Scanner
git pull
cd /home/pi/Scripts/Pick2Light #change to Pick2Light folder
git pull #pulls recent version from gitHub
cd /home/pi/Scripts/RaspberryPIScripts #change to Rasberry PI Script folder
git pull #pulls recent version from gitHub
cd /home/pi/Scripts/RoboticArmCode #change to Robotic Arm Code folder
git pull #pulls recent version from gitHub

echo "Finished syncing repositories!"
