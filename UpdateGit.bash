#!/bin/bash
newHome=/home/pi/Scripts

echo "Updating Pi"

sudo apt-get update

cd /home/pi/Scripts/Pick2Light
git pull
cd /home/pi/Scripts/RaspberryPIScripts
git pull
cd /home/pi/Scripts/RoboticArmCode
git pull

echo "finished"