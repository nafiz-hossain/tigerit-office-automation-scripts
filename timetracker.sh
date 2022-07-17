#variables
delay=0.2
#get current time
time=$(date "+%H:%M")
taskTitle="* Checking $1"
duration=$2


#content=$(curl -L https://timetracker.tigeritbd.com/)

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
xdotool type "Testing"
sleep $delay 
xdotool key Return


sleep $delay 
xdotool key Tab   
sleep 1
xdotool type "$taskTitle"
echo $taskTitle
sleep $delay 


#time
xdotool mousemove 536 238 click 1
sleep $delay
xdotool key End BackSpace BackSpace BackSpace BackSpace BackSpace
xdotool type $time
sleep $delay
xdotool key Tab Tab Tab Tab $duration Return


#logout 
sleep $delay
xdotool mousemove 1864 158 click 1
sleep $delay
xdotool key Tab Tab Tab Tab Return 
xdotool key ctrl+w
