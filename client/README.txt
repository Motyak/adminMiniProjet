Après l'installation effectuée, la machine enverra toutes les 5 minutes des informations concernant son etat au serveur.

Installation : 
On suppose que la librairie psutil est déjà installée (sinon, faire 'sudo pip install psutil')
sur la machine client, executer ./installation_client.sh

Utilisation : (automatique)

On suppose qu'une machine serveur est déjà configurée, on aura besoin de son adresse IP.
On suppose que la machine serveur possède une IP statique.
On suppose que la machine peut echanger avec la machine serveur.
On suppose que la machine possède une ip sur l'interface ethernet.
On suppose que la machine possède les paquets crontab et netcat(nc).
On identifie la machine par son adresse ip sur l'interface eth0.
On utilise le port 55555 pour la communication TCP serveur-clients.
On installe le script dans /usr/include/bin/miniProjet/


