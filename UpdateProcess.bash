#This Script updates all programs on Raspberry Pi 
newHome=/home/pi/Scripts

echo "Updating and upgrading OS..."

sudo apt-get update
sudo apt-get -y upgrade

sudo bash /home/pi/Scripts/RaspberryPIScripts/UpdateGit.bash

echo "Finished updating and upgrading OS! You may need to restart now."
