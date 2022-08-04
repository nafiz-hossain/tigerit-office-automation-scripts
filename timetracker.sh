#variables
delay=.1
#get current time
time=$(date "+%H:%M")

#arguments passed
activity="$1"
taskTitle="$2"
duration=$3


#check number of argument
if [ "$#" -eq 3 ]; then
    taskTitle="* $activity on $2"
elif [ "$#" -eq 2 ]; then
    taskTitle="* Checking $1"
    duration=$2
fi






#opening browser and visit timetracker
xdg-open https://timetracker.tigeritbd.com/ 






#setting window size full
#sleep 2
#xdotool key Alt_L+F10

#Login
sleep .5
xdotool key Tab 
sleep $delay
xdotool key Tab 
sleep $delay
xdotool key Tab 
sleep $delay
xdotool key Tab 
sleep $delay
xdotool key Return


#creating a task
sleep 1.5

xdotool key Tab 
sleep $delay
xdotool key Tab 
sleep $delay
xdotool key Tab 
sleep $delay
xdotool key Return


#Input in CreateForm

sleep $delay 
xdotool type $duration
sleep $delay
xdotool key Tab 
sleep $delay 
xdotool key Return
sleep $delay 
xdotool type "International Consumer"
sleep $delay 
xdotool key Return


sleep $delay 
xdotool key Tab 
sleep $delay 
xdotool key Return
sleep $delay 
xdotool type "Commchat Desktop"
sleep $delay 
xdotool key Return


sleep $delay 
xdotool key Tab 
sleep $delay 
xdotool key Return
sleep $delay 
#conditional check on activity
if [ "$#" -eq 2 ]; then xdotool type "Testing"; 
elif [ "$#" -eq 3 ]; then xdotool type ${activity:0:3};
fi

sleep $delay 
xdotool key Return


sleep $delay 
xdotool key Tab   
sleep 1
xdotool type "$taskTitle"
echo $taskTitle
sleep $delay 


#time
xdotool mousemove 545 773 click 1 #save button
sleep $delay
xdotool key Tab Tab Tab Tab $duration Return


#logout 
sleep $delay
xdotool mousemove 1864 130 click 1 #profile icon
sleep $delay
xdotool key Tab Tab Tab Tab Return 
xdotool key ctrl+w
