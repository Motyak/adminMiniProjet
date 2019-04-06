#!/bin/bash

#afficher toutes les saves dispo
ls .backup -1 | sort -r > .tmp
i=1
while IFS='' read -r line || [[ -n "$line" ]];do
		echo "$i) $line"
		i=$((i+1))
done < .tmp

#demander le nom de la save a backup
echo -e "\nEntrez le num de la save : "
read userInput

filename=$(cat .tmp | head -$userInput | tail -1)

#backup la save
cp .backup/$filename bdd.db

#supprime le fichier .tmp
rm .tmp