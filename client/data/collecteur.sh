#!/bin/sh

if [ "$#" -ne 2 ];then
    echo -e "\nUsage : ./collecteur.sh *ipAddress* *port*\n"
    exit 1
fi

#eth0 ip address
ifconfig eth0 | grep 'inet ad' | cut -d: -f2 | awk '{print $1}' > .input

#date, format : YYYY/MM/DD
date +"%Y/%m/%d">> .input

#time, format : HH:MM:SS
date +"%T" >> .input

#cpu usage, %
top -bn1 | grep load | awk '{printf "%s\n", $(NF-2)}' | sed 's/.$//' >> .input
#./s_cpuUsage.py >> .input

#mem usage, %
free -m | awk 'NR==2{printf "%.2f\n",$3*100/$2 }' >> .input

#disk usage ('/' disk ), %
df -h | awk '$NF=="/"{printf "%s\n",$5}' | sed 's/.$//' >> .input

#nb of processes
ps aux | wc -l >> .input
#./s_nbProcesses.py >> .input

#nb of active users
who | awk '{ print $1 }' | sort | uniq | wc -l >> .input

#send to tcp server
nc $1 $2 < .input

#remove .input file
rm .input