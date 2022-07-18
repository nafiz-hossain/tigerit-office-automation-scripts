#!/bin/bash
to="0"


read -p "From [format YYYY-MM-DD]: " from
read -p "To [format YYYY-MM-DD]: " to


if [[ -z $to ]] || [[ -z $from ]]; then echo "User pressed ENTER with no input text"; fi
cd /home/tigerit/TigerIT/projects/communicator-desktop-pwa
git reset --hard
git checkout dev
git pull 

if [[ -z $from ]]; then git log --pretty=format:"%B" --date=short --reverse --all --since=7.days.ago >lastweektask.txt

else
        git log --pretty=format:"%B" --date=short --reverse --all --after="$from" --until="$to" >lastweektask.txt
fi

sleep 1
#formation
sort lastweektask.txt | uniq > tmp && mv tmp lastweektask.txt #sorts and removes duplicate line
grep -v -i "merge\|conflicts\|package-lock.json\|1.2." lastweektask.txt > tmp && mv tmp lastweektask.txt #removes line containing a string
grep -v '^[[:blank:]]*$' lastweektask.txt >lastweektask.txt.tmp && mv lastweektask.txt{.tmp,}  #removes empty line
awk '{printf("%d. %s\n", NR, $0)}' lastweektask.txt > tmp && mv tmp lastweektask.txt #put numbers before every line
