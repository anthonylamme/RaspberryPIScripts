import os as os
import time as time
"""
sleep 30s; shutdown -h now
"""
path="wow"
def ShutDownOp(seconds):
    
    time.sleep(seconds)
    os.system("sudo shutdown now -h")
    
def RestartOp(seconds):
    
    time.sleep(seconds)
    os.system("sudo shutdown -r -t 1")

def CancelOp():

    os.system("sudo shutdown -c")
    
def UpdateGit():

    os.system("sudo bash /home/pi/Scripts/RaspberryPIScripts/UpdateGit.bash")
    
def UpdateBot():

    os.system("sudo bash /home/pi/Scripts/home/pi/Scripts/RaspberryPIScripts/replaceMeBot.bash")
