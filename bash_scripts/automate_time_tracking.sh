#!/bin/bash

# Set delays for better synchronization
delay=0.25
short_delay=0.1

# Get current time
time=$(date "+%H:%M")

# Check Caps Lock status and turn it off if it's on
caps_lock_status=$(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p')
if [ "$caps_lock_status" == "on" ]; then
  echo "Caps lock is on. Turning it off."
  xdotool key Caps_Lock
else
  echo "Caps lock is already off."
fi

# Get title from clipboard (assuming it's copied from Asana or similar)
sleep "$short_delay"
xdotool key Ctrl+a
sleep "$short_delay"
xdotool key Ctrl+c
sleep "$delay"
clipboard_content=$(xclip -o -selection clipboard)
echo "Title from clipboard: $clipboard_content"

# Default values for activity, duration, and task title
activity="Testing"
duration="1"
task_title="* Checking the change of $clipboard_content"

# Determine task title based on arguments
if [ "$#" -eq 3 ]; then
    task_title="* $1 on $2"
elif [ "$#" -eq 2 ]; then
    task_title="$1"
    duration="$2"

    case ${task_title:0:3} in
        "Inv" | "inv" | "Pre" | "pre" | "Res" | "res")
            task_title="* $1"
            ;;
        *)
            task_title="* Checking the change of $1"
            ;;
    esac
fi

echo "Final Task Title: $task_title"

# Open browser and visit timetracker
xdg-open https://timetracker.tigeritbd.com/index.php/en/login 
xdotool key ctrl+r

# Login
sleep "$short_delay"
xdotool key Tab Tab Tab Tab Return			

# Create a task
sleep "$short_delay"
xdotool key Tab Tab Tab Return

# Input in CreateForm
sleep "$short_delay"
xdotool type "$duration"
sleep "$short_delay"
xdotool key Tab Tab Return
sleep "$short_delay" 
xdotool key Return
sleep "$short_delay" 
xdotool type "International Consumer"
sleep "$short_delay" 
xdotool key Return
sleep "$short_delay" 
xdotool key Tab 
sleep "$short_delay" 
xdotool key Return
sleep "$short_delay" 
xdotool type "Commchat Desktop"
sleep "$short_delay" 
xdotool key Return
sleep "$short_delay" 
xdotool key Tab 
sleep "$short_delay"
xdotool key Return
sleep "$short_delay"
xdotool type "Testing"
sleep "$short_delay" 
xdotool key Return
sleep "$short_delay" 
xdotool key Tab   
sleep "$short_delay"
xdotool type "$task_title"
sleep "$short_delay" 
xdotool key Tab Tab Tab Return
sleep "$delay"
xdotool key Tab Tab Tab Tab "$duration" Return

# Logout 
sleep "$delay" 
exit 0
