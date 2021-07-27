#!/bin/bash


num_a=1

num_b=1

num_c=1
sleep=0.08

while [ $num_a -le 5 ]; do
      
	xdotool mousemove 1205 737 click 1 &
		echo "here i am"
		num_b=1

                while [  $num_b -le 1 ]; do

		sleep .1
			
			xdotool key S &
				sleep $sleep
			xdotool key e &
				sleep $sleep
			xdotool key a &
				sleep $sleep
			xdotool key r &
				sleep $sleep
			xdotool key c &
				sleep $sleep
			xdotool key h &
				sleep $sleep
			xdotool key i &
				sleep $sleep
			xdotool key n &
				sleep $sleep
			xdotool key g &
				sleep $sleep

			xdotool key space f &
				sleep $sleep
			xdotool key o &
				sleep $sleep
			xdotool key r &
				sleep $sleep

			xdotool key space m &
				sleep $sleep
			xdotool key  i &
				sleep $sleep
			xdotool key s &
				sleep $sleep
			xdotool key s &
				sleep $sleep
			xdotool key i &
				sleep $sleep
			xdotool key n &
				sleep $sleep
			xdotool key g space &
				sleep $sleep

			xdotool key t &
				sleep $sleep
			xdotool key  e &
				sleep $sleep
			xdotool key x &
				sleep $sleep
			xdotool key t space &
				sleep $sleep
			

                        num_b=$(($num_b+1))



                done
xdotool type $num_c
 num_c=$(($num_c+1))

sleep .1

xdotool mousemove 1342 728 click 1

        num_a=$(($num_a+1))
done
