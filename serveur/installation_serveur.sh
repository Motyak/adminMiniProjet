#!/bin/sh

#these parameters must be the same as in the clients script
readonly IP_ADDR_SERVER="$(ifconfig eth0 | grep 'inet ad' | cut -d: -f2 | awk '{print $1}')"
readonly LISTENING_PORT="55555"

echo "Creation du repertoire d'installation /usr/local/bin/miniProjet..."
mkdir /usr/local/bin/miniProjet
echo "Copie des scripts dans le repertoire d'installation..."
cp *.sh *.py /usr/local/bin/miniProjet/
echo "Creation de la base de données dans le repertoire d'installation..."
sqlite3 bdd.db <<req
create table EXTRACTION(id integer primary key autoincrement,machine text,date text,heure text,type text,info real);
create table ALERTE(id integer primary key autoincrement,titre text,date text,heure text,lien text);
req
echo "Ajout des taches crontab..."
(crontab -l 2>/dev/null; echo "@reboot /usr/local/bin/miniProjet/server.sh $IP_ADDR_SERVER $LISTENING_PORT") | crontab -
(crontab -l 2>/dev/null; echo "@daily /usr/local/bin/miniProjet/delete.sh") | crontab -
(crontab -l 2>/dev/null; echo "@daily python3 /usr/local/bin/miniProjet/webParser.py") | crontab -
(crontab -l 2>/dev/null; echo "@weekly /usr/local/bin/miniProjet/backup.sh") | crontab -
echo "Installation termine!"