#!/bin/bash

# Restart LCD by setting PowerSaveMode property
restart_lcd() {
    busctl --user set-property org.gnome.Mutter.DisplayConfig /org/gnome/Mutter/DisplayConfig org.gnome.Mutter.DisplayConfig PowerSaveMode i 1
    busctl --user set-property org.gnome.Mutter.DisplayConfig /org/gnome/Mutter/DisplayConfig org.gnome.Mutter.DisplayConfig PowerSaveMode i 0
}

# Restart mouse pointer driver
restart_mouse_driver() {
    sudo modprobe -r psmouse
    sudo modprobe psmouse
}

# Main function
main() {
    # Restart LCD
    echo "Restarting LCD..."
    restart_lcd
    echo "LCD restarted successfully."

    # Restart mouse pointer driver
    echo "Restarting mouse pointer driver..."
    restart_mouse_driver
    echo "Mouse pointer driver restarted successfully."
}

# Call the main function
main
