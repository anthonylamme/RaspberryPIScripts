"""
Custom Library to help with command control of python slack bot

"""
import os as os #used for OS related tasks
import time as time #used for time control


"""
Shuts down system after seconds. Seconds can be a decimal but was designed for integer values
"""
def ShutDownOp(seconds):
    
    time.sleep(seconds)
    os.system("sudo shutdown now -h")#sends command to shut system down
"""
Restarts system after a number of seconds. Can be Float
"""
def RestartOp(seconds):
    
    time.sleep(seconds)
    os.system("sudo shutdown -r -t 1")
"""
Cancels system command to shutdown/restart
"""
def CancelOp():

    os.system("sudo shutdown -c")
"""
Updates Programs running on RPi
"""
def UpdateGit():

    os.system("sudo bash /home/pi/Scripts/RaspberryPIScripts/UpdateGit.bash")
"""
Will update Slack Bot. Still needs work
"""
def UpdateBot():

    os.system("sudo bash /home/pi/Scripts/home/pi/Scripts/RaspberryPIScripts/replaceMeBot.bash")
