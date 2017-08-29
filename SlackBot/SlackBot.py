"""
    This program will Run a SlackBot that will act as a the user interface with the pick2light system.
The program requires that a txt file name Token.txt is placed in the tokens folder. This text file
needs to havethe first line with the number of the cell, second line with the name on slack for the bot
and the third line with the token for the slackbot.
"""


import re #used to compare incoming text with pattern
import os # library for commanding OS and file retrieval
import time as time#pull time data from pi
import json #handler for JSON files
import psutil #CPU/Memory utility
import BotOps as OPS #Custom Library for commands
import requests as req #maybe used to pull files from slack to update system
from slackclient import SlackClient #the slack Client Library

MainFolder='/home/pi/SlackData/'
TokenAdd=MainFolder+'Tokens/Token.txt'


file_obj=open(TokenAdd,'r')
Number=file_obj.readline().rstrip().strip(' ')
myName=file_obj.readline().rstrip().strip(' ')
Token=file_obj.readline().rstrip().strip(' ')
file_obj.close()

csv_path=MainFolder+'ItemList.csv'
json_path=MainFolder+'JSONData/Order.json'

#print Number
#print myName #sanity check to ensure write information is pulled from file
#print Token

Report_Path=MainFolder+'Data.zip' #file information for data transmission from Pick2light to Admin. 
slack_client =SlackClient(Token)

user_list = slack_client.api_call("users.list") #files self on user list. if there is a error with this line it is the Token not the code
for user in user_list.get('members'):
    if user.get('name') == 'printscannerpi1': #makes sure it has its name as a id
        slack_user_id = user.get('id') #retrieves slack encoded id
        #print user.get('id')
        break
    #else:
        #print myName.decode(encoding='utf-8',errors='strict')
        #print user.get('name')
if slack_client.rtm_connect():#connects to slack client
    #print "Connected" #sanity check
    slack_client.rtm_send_message('allpis',"%s here"%Number) #will notify all channel that its online
    
    while True:
        for message in slack_client.rtm_read(): #for every message in the client while its reading

            if 'file' in message and 'url_private' in message['file']:
                #print "File received: %s" % json.dumps(message, indent=2)
                file_info=message['file']['url_private'].strip()
                file_type=message['file']['filetype'].strip()
                file_name=message['file']['name'].strip()

                if file_type == 'csv':
                    file2b=req.get(file_info,headers={'Authorization': 'Bearer %s'%P2L_Token})
                    with open(csv_path,'wb') as f:
                        f.write(file2b.content)

                elif file_type == 'xlsx' or file_type == 'xlsm' or file_type == 'xls':

                    file_name=file_name.replace(' ','')
                    
                    pathway=MainFolder+'%s'%file_name
                    
                    #print "%s file needs formating"%file_name
                    
                    file2b=req.get(file_info,headers={'Authorization': 'Bearer %s'%P2L_Token})
                    with open(pathway,'wb') as f:
                        f.write(file2b.content)
                        
                    OPS.convertOp(pathway,csv_path)

                elif file_type == 'javascript':
                    
                    #pathway='/home/pi/SlackData/JSONData/Order.json'
                    
                    file2b=req.get(file_info,headers={'Authorization': 'Bearer %s'%P2L_Token})
                    with open(json_path,'wb') as f:
                        f.write(file2b.content)
                        
                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n Thank you for your order",
                        as_user=True)
                
                elif file_type == 'zip':
                    
                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n Here is the report",
                        as_user=True)
                    
                else:

                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n I was unable to read file type",
                        as_user=True)
                
            if 'text' in message and message['text'].startswith("<@%s>"%slack_user_id): # if text has the @user id:
                
                #print "Message received: %s" % json.dumps(message, indent=2) #prints json file on cmdline for checking
                
                message_text = message['text'].\
                    split("<@%s>" % slack_user_id)[1].\
                    strip()#splits message from user name

                if re.match(r'.*(shutdown).*', message_text, re.IGNORECASE): #shutdown command. it will shut off the RPi in 10 secs 

                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n shutting down in 10 secs",
                        as_user=True)
                    
                    OPS.ShutDownOp(10)#function from BotOPS to shutdown system needs number of seconds till shutdown
                    
                if re.match(r'.*(restart).*',message_text,re.IGNORECASE):#restart command

                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n Restarting in 10 secs",
                        as_user=True)
                    
                    OPS.RestartOp(10)#function from BotOPS to restart system needs number of seconds till restart
                          
                if re.match(r'.*(send).*',message_text,re.IGNORECASE): #command to send contents of data folder
                    os.system('zip -r -j %s %s'%(Report_Path,(MainFolder+'Data'))) #zips data folder for transmission
                    
                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n Sending Report",
                        as_user=True) #notifies user 
                    

                    slack_client.api_call(
                        "files.upload",
                        channels=message['channel'],
                        file=open(Report_Path,'rb'),
                        filename='%s'%Report_Path,
                        filetype='auto',
                        initail_comment='\n Here you go') #uploads file
                          
                if re.match(r'.*(cpu).*',message_text,re.IGNORECASE): #command to check CPU useage used more for checking system for load on CPU

                    cpu_pct=psutil.cpu_percent(interval=1,percpu=False)
                    
                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n My CPU is at %s%%."%cpu_pct,
                        as_user=True)
                          
                if re.match(r'.*(memory|ram).*',message_text,re.IGNORECASE): #Checks RAM usage. Shouldn't run above 80% for system stablilty

                    mem=psutil.virtual_memory()
                    mem_pct =mem.percent
                    
                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n My memory is at %s%%."%mem_pct,
                        as_user=True)
                          
                if re.match(r'.*(temperature).*',message_text,re.IGNORECASE): #Checks Temperature used to increase lifetime of mechine
                    
                    file_object  = open('/sys/class/thermal/thermal_zone0/temp', 'r') 
                    temp=file_object.read(2)

                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n My temperature is at %s."%temp,
                        as_user=True)
                          
                if re.match(r'.*(help).*',message_text,re.IGNORECASE): #help command to show commands that are used
                    
                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n Always happy to help\n Type: shutdown to shutdown \n Type: restart to restart\n Type: send to recieve report\n Type: CPU to recieve percent of CPU used\n Type: memory or ram to recieve percent of ram used\n Type: temperture to recieve temperture data \n cancel to cancel shutdown",
                        as_user=True)
                    
                if re.match(r'.*(cancel).*',message_text,re.IGNORECASE): #cancels previous commands used mostly to stop shutdown or restart

                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n cancelling previous shutdown/restart",
                        as_user=True)

                    OPS.CancelOp()
                if re.match(r'.*(update).*',message_text,re.IGNORECASE):#updates programs running on RPi

                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n Updating Program Folder",
                        as_user=True)
                    
                    OPS.UpdateGit()

                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n Updated",
                        as_user=True)
                    
                if re.match(r'.*(cell|number).*',message_text,re.IGNORECASE): #tells user which number cell the bot is

                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n My Cell number is %s"%Number,
                        as_user=True)
                    
                if re.match(r'.*(name).*',message_text,re.IGNORECASE): #will be used to check for recieving files

                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n my name is %s. How can I help?"%myName,
                        as_user=True)
                    
                if re.match(r'.*(monitor).*',message_text,re.IGNORECASE): #will monitor serial input from Pi
                    
                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n Monitoring",
                        as_user=True)
                    
                if re.match(r'.*(date).*',message_text,re.IGNORECASE): #will monitor serial input from Pi
                    date=time.localtime(time.time())
                    outputDate='%d_%d_%d'%(date[1],date[2],(date[0]%100))
                    slack_client.api_call(
                        "chat.postMessage",
                        channel=message['channel'],
                        text="\n the date is %s"%outputDate,
                        as_user=True)
              
                    
            time.sleep(1)#wait a second  between messages to give user time to send command


