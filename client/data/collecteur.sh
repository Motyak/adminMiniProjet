#!/bin/sh

if [ "$#" -ne 2 ];then
    echo -e "\nUsage : ./collecteur.sh *ipAddress* *port*\n"
    exit 1
fi

readonly DRY="/usr/local/bin/miniProjet"

#eth0 ip address
hostname -I | awk '{print $1}' > $DRY/.input
#ifconfig eth0 | grep 'inet ad' | cut -d: -f2 | awk '{print $1}' > .input

#date, format : YYYY/MM/DD
date +"%Y/%m/%d">> $DRY/.input

#time, format : HH:MM:SS
date +"%T" >> $DRY/.input

#cpu usage, %
top -bn1 | grep load | awk '{printf "%s\n", $(NF-2)}' | sed 's/.$//' >> $DRY/.input
#./s_cpuUsage.py >> .input

#mem usage, %
free -m | awk 'NR==2{printf "%.2f\n",$3*100/$2 }' >> $DRY/.input

#disk usage ('/' disk ), %
df -h | awk '$NF=="/"{printf "%s\n",$5}' | sed 's/.$//' >> $DRY/.input

#nb of processes
#ps aux | wc -l >> .input
python3 s_nbProcesses.py >> $DRY/.input

#nb of active users
who | awk '{ print $1 }' | sort | uniq | wc -l >> $DRY/.input

#send to tcp server
nc $1 $2 < $DRY/.input

#remove .input file
#rm $DRY/.input
