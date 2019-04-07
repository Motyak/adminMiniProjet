#!/bin/sh

#installation directory absolute path
readonly DRY="/usr/local/bin/miniProjet"

#these parameters must be the same as in the clients script
readonly IP_ADDR_SERVER="$(ifconfig eth0 | grep 'inet ad' | cut -d: -f2 | awk '{print $1}')"
readonly LISTENING_PORT="55555"

echo "Creation du repertoire d'installation $DRY..."
sudo sh -c "mkdir $DRY && chown $(whoami):$(whoami) $DRY"
mkdir $DRY/.backup

echo "Copie des scripts dans le repertoire d'installation..."
cp data/*.sh data/*.py $DRY/
chmod -R u+x $DRY/*.sh $DRY/*.py

echo "Creation de la base de données dans le repertoire d'installation..."
sqlite3 $DRY/bdd.db <<req
create table EXTRACTION(id integer primary key autoincrement,machine text,date text,heure text,type text,info real);
create table ALERTE(id integer primary key autoincrement,titre text,date text,heure text,lien text);
create table CRISE(id integer primary key autoincrement,machine text,type text,info real,date text,heure text);
req

echo "Ajout des taches crontab..."
(crontab -l 2>/dev/null; echo "@reboot $DRY/server.sh $IP_ADDR_SERVER $LISTENING_PORT") | crontab -
(crontab -l 2>/dev/null; echo "@daily $DRY/delete.sh") | crontab -
(crontab -l 2>/dev/null; echo "@daily python3 $DRY/webParser.py") | crontab -
(crontab -l 2>/dev/null; echo "@weekly $DRY/backup.sh") | crontab -
(crontab -l 2>/dev/null; echo "*/5 * * * * $DRY/detectionCrise.sh") | crontab -

echo "Lancement du serveur..."
$DRY/server.sh $IP_ADDR_SERVER $LISTENING_PORT &

echo "Installation termine!"