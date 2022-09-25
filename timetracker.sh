#variables
delay=.2
delay1=0
#get current time
time=$(date "+%H:%M")

#arguments passed
activity="$1"
taskTitle="$2"
duration=$3

caps_lock_status=$(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p')
if [ $caps_lock_status == "on" ]; then
  echo "Caps lock on, turning off"
  xdotool key Caps_Lock
else
  echo "Caps lock already off"
fi



#check number of argument
if [ "$#" -eq 3 ]; then
    taskTitle="* $activity on $2"
    echo "came to block A"
elif [ "$#" -eq 2 ]; then
    taskTitle="$1"
    duration=$2

	sleep .1
    echo "came to block B ${taskTitle:0:3}"

    if [ ${taskTitle:0:3} == "Inv" ] || [ ${taskTitle:0:3} == "inv" ]; then
    taskTitle="* $1"
    elif [ ${taskTitle:0:3} == "Pre" ] || [ ${taskTitle:0:3} == "pre" ]; then
    taskTitle="* $1"
    elif [ ${taskTitle:0:3} == "Res" ] || [ ${taskTitle:0:3} == "res" ]; then
    taskTitle="* $1"
    else
    taskTitle="* Checking the change of $1"
    fi
    echo "$taskTitle"
fi






#opening browser and visit timetracker
xdg-open https://timetracker.tigeritbd.com/index.php/en/login 
sleep 1
xdotool mousemove 524 789 click 1
sleep $delay
xdotool key Ctrl+r
sleep $delay



#setting window size full
#sleep 2
#xdotool key Alt_L+F10

#Login
sleep .8
xdotool key Tab Tab Tab Tab Return
sleep .8
xdotool key Return


#creating a task
sleep .8

xdotool key Tab 
xdotool key Tab 
xdotool key Tab 
xdotool key Return


#Input in CreateForm
sleep .5
xdotool type $duration
sleep $delay1
xdotool key Tab Tab
sleep $delay1 
xdotool key Return
sleep $delay1 
xdotool type "International Consumer"
sleep $delay1 
xdotool key Return


sleep $delay1 
xdotool key Tab 
sleep $delay1 
xdotool key Return
sleep $delay1 
xdotool type "Commchat Desktop"
sleep $delay1 
xdotool key Return


sleep $delay1 
xdotool key Tab 
sleep $delay1
xdotool key Return
sleep $delay1 
#conditional check on activity
if [ "$#" -eq 2 ]; then xdotool type "Testing"; 
elif [ "$#" -eq 3 ]; then xdotool type ${activity:0:3};
fi

sleep $delay1 
xdotool key Return


sleep $delay1 
xdotool key Tab   
sleep $delay1
xdotool type "$taskTitle"

sleep $delay1 


#time
xdotool mousemove 546 1170 click 1 #save button
sleep $delay
xdotool key Tab Tab Tab Tab $duration Return


#logout 
#sleep $delay
#xdotool mousemove 1864 130 click 1 #profile icon
#sleep .3
#xdotool key Tab Tab Tab Tab Return
sleep $delay 
xdotool key ctrl+w
