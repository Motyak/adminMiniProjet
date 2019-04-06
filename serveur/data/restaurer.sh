#!/bin/bash

#installation directory absolute path
readonly DRY="/usr/local/bin/miniProjet"

#afficher toutes les saves dispo
ls $DRY/.backup -1 | sort -r > $DRY/.tmp
i=1
while IFS='' read -r line || [[ -n "$line" ]];do
		echo "$i) $line"
		i=$((i+1))
done < $DRY/.tmp

#demander le nom de la save a backup
echo -e "\nEntrez le num de la save : "
read userInput

filename=$(cat $DRY/.tmp | head -$userInput | tail -1)

#backup la save
cp $DRY/.backup/$filename $DRY/bdd.db

#supprime le fichier .tmp
rm $DRY/.tmp