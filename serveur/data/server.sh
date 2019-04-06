#!/bin/bash

if [ "$#" -ne 2 ];then
    echo -e "\nUsage : ./server.sh *ipAddress* *port*\n"
    exit 1
fi

while :
do
	#on host sur adr $1 port $2, sortie dans fichier '.output'
	nc -l $1 $2 > .output

	#lecture du fichier ligne par ligne
	i=0
	while IFS='' read -r line || [[ -n "$line" ]];do
		infos[$i]=$line
		i=$i+1
	done < .output

	#insertion des infos dans la bdd
	sqlite3 bdd.db <<req
	insert into EXTRACTION values(null,'${infos[0]}','${infos[1]}','${infos[2]}','cpuUsage','${infos[3]}');
	insert into EXTRACTION values(null,'${infos[0]}','${infos[1]}','${infos[2]}','memUsage','${infos[4]}');
	insert into EXTRACTION values(null,'${infos[0]}','${infos[1]}','${infos[2]}','diskUsage','${infos[5]}');
	insert into EXTRACTION values(null,'${infos[0]}','${infos[1]}','${infos[2]}','nbProcesses','${infos[6]}');
	insert into EXTRACTION values(null,'${infos[0]}','${infos[1]}','${infos[2]}','nbUsers','${infos[7]}');
req
done