#!/bin/bash

# Continuous monitoring of mouse cursor location
# This script continuously displays the current mouse cursor location with a high refresh rate.

# Define the refresh rate in seconds (0.0001 seconds for high precision)
refresh_rate=0.0001

# Command to continuously monitor mouse cursor location using xdotool
# '-t' option is used to remove the header, and '-n' specifies the refresh rate
watch_command="watch -t -n $refresh_rate xdotool getmouselocation"

# Execute the command
$watch_command
