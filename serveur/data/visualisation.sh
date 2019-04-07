#!/bin/bash

#installation directory absolute path
readonly DRY="/usr/local/bin/miniProjet"

dateDebut=$(date +%Y/%m/%d -d "yesterday")

#afficher toutes les machines enregistrees
sqlite3 $DRY/bdd.db 'select distinct machine from EXTRACTION' > $DRY/.tmp
i=1
while IFS='' read -r line || [[ -n "$line" ]];do
		echo "$i) $line"
		i=$((i+1))
done < $DRY/.tmp

#selectionner la machine dont on souhaite visualiser l'historique
echo -e "\nEntrez le num de la machine : "
read userInput
machine=$(cat $DRY/.tmp | head -$userInput | tail -1)

#Affiche historique de type 'cpu usage' de la machine datant de ces dernieres 24h
echo $(sqlite3 $DRY/bdd.db "select heure,info from EXTRACTION where date>='$dateDebut' and type='cpuUsage' and machine='$machine'") > $DRY/.tmp
$DRY/cpuUsage.gp
#Affiche historique de type 'mem usage' de la machine datant de ces dernieres 24h
sqlite3 $DRY/bdd.db "select heure,info from EXTRACTION where date>='$dateDebut' and type='memUsage' and machine='$machine'" > $DRY/.tmp
$DRY/memUsage.gp
#Affiche historique de type 'disk usage' de la machine datant de ces dernieres 24h
sqlite3 $DRY/bdd.db "select heure,info from EXTRACTION where date>='$dateDebut' and type='diskUsage' and machine='$machine'" > $DRY/.tmp
$DRY/diskUsage.gp

#supprime le fichier .tmp
rm $DRY/.tmp