Après l'installation effectuée, un serveur TCP ecoutera sur le port 55555 et enregistrera les informations envoyés à celui-ci dans la base de données. Il stockera les nouvelles alertes dans la base de données. Il supprimera les informations datant de plus d'un mois stockées dans la base de données tous les jours. Il fera un backup de la base de données chaque semaine.

Installation : sur la machine client, executer ./installation_client.sh

Utilisation : (serveur TCP->automatique,stockage alertes->automatique,suppression des vieux enregistrements->automatique)
		Pour faire un backup manuel, lancer /usr/include/bin/miniProjet/backup.sh
		Pour restaurer un backup, lancer /usr/include/bin/miniProjet/restaurer.sh puis suivez les instructions.

On suppose que la machine possède une IP statique.
On suppose que la machine peut echanger avec les machines client.
On suppose que la machine possède les paquets crontab, netcat(nc), sqlite3
On suppose que la machine possède une ip sur l'interface ethernet.
On utilise le port 55555 pour la communication TCP serveur-clients.
On installe les scripts dans /usr/include/bin/miniProjet/
On cree la base de données dans /usr/include/bin/miniProjet/


