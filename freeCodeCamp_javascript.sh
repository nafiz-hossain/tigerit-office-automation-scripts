delay=0.1
delay2=0.2
sleep 4
#sleep 2
sleep $delay
xdotool key ctrl+c
sleep $delay
clipboard_content=`xclip -o -selection clipboard`
echo "$clipboard_content"

sleep $delay
eval $(xdotool getmouselocation --shell)
echo $X $Y
X=$((X+600))
echo $X $Y
sleep $delay
xdotool mousemove $X $Y click 1 
sleep $delay
xdotool key ctrl+a
sleep $delay
xdotool key ctrl+c
sleep $delay
solution=`xclip -o -selection clipboard`

cd /home/tigerit/TigerIT/projects/Coding/freeCodeCamp/JavaScript\ Algorithms\ and\ Data\ Structures/
#param="'$*'"
#echo $param
oldstr=" "
newstr="_"
result=$(echo $clipboard_content | sed "s/$oldstr/$newstr/g")
result=$(echo $result | sed "s/'//g")
echo $result
echo $solution










sleep $delay
xdotool key ctrl+Alt+t
sleep $delay2
xdotool type "cd /home/tigerit/TigerIT/projects/Coding/freeCodeCamp/JavaScript\ Algorithms\ and\ Data\ Structures/"
xdotool key Return



sleep $delay
xdotool type "nano $result"
sleep $delay
xdotool key Return

sleep $delay
xdotool key ctrl+shift+v
sleep $delay
xdotool key ctrl+s
sleep $delay
xdotool key ctrl+x
sleep $delay
xdotool key ctrl+shift+W

git add $result
git commit -m "$result solved"
git push origin -u master
