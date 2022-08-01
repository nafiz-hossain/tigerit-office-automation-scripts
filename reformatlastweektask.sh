cd /home/tigerit/TigerIT/projects/communicator-desktop-pwa
awk '{print substr($0,4)}' lastweektask.txt> tmp.txt && mv tmp.txt lastweektask.txt
grep -v '^[[:blank:]]*$' lastweektask.txt >lastweektask.txt.tmp && mv lastweektask.txt{.tmp,}  #removes empty line
awk '{printf("%d. %s\n", NR, $0)}' lastweektask.txt > tmp && mv tmp lastweektask.txt #put numbers before every line
