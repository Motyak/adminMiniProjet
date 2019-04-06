#!/bin/sh

if [ "$#" -ne 1 ];then
    echo -e "\nUsage : ./installation_client.sh *serverIpAddress*\n"
    exit 1
fi

#these parameters must be the same as in the server script
readonly IP_ADDR_SERVER=$1
readonly PORT='55555'

echo "Creation du repertoire d'installation /usr/local/bin/miniProjet..."
mkdir /usr/local/bin/miniProjet
echo "Copie du script collecteur.sh dans le repertoire d'installation..."
cp data/collecteur.sh /usr/local/bin/miniProjet/
echo "Ajout de la tache crontab..."
(crontab -l 2>/dev/null; echo "*/5 * * * * /usr/local/bin/miniProjet/collecteur.sh $IP_ADDR_SERVER $PORT") | crontab -
echo "Installation termine!"