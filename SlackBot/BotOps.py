"""
Custom Library to help with command control of python slack bot

"""
import os as os #used for OS related tasks
import time as time #used for time control
import csv as item_list #used to format csv

r=[] #empty list to hold csv

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
"""
converts xlsx files to csv and formats for Pick2Light system
"""
def convertOp(path,path2be):

    os.system('xlsx2csv %s > %s'%(path,path2be))
    i=0
    count=2
    
    with open(path2be,'rb') as f:
        freader=item_list.reader(f,delimiter=',')
        for row in freader:
            if i == count and count < 21:
                r.append(row)
                count+=3
            i+=1    
    print 'Processing'
    with open(path2be,'wb') as g:
        gwriter=item_list.writer(g,delimiter=',')
        for list in r:
            while len(list) > 27:
                list.pop(27)
            list.pop(0)
            gwriter.writerow(list)
