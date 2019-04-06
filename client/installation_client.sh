#!/bin/sh

if [ "$#" -ne 1 ];then
    echo -e "\nUsage : ./installation_client.sh *serverIpAddress*\n"
    exit 1
fi

readonly DRY="/usr/local/bin/miniProjet"

#these parameters must be the same as in the server script
readonly IP_ADDR_SERVER=$1
readonly PORT='55555'

echo "Creation du repertoire d'installation $DRY..."
sudo sh -c "mkdir $DRY && chown $(whoami):$(whoami) $DRY"
echo "Copie du script collecteur.sh dans le repertoire d'installation..."
cp data/*.sh data/*.py $DRY
chmod -R u+x $DRY/*.sh $DRY/*.py
echo "Ajout de la tache crontab..."
(crontab -l 2>/dev/null; echo "*/5 * * * * $DRY/collecteur.sh $IP_ADDR_SERVER $PORT") | crontab -
echo "Installation termine!"