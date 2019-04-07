Projet disponible sur https://github.com/Motyak/adminMiniProjet

Options de fonctionnement du projet :
Il faut d'abord installer le 'programme serveur' sur la machine serveur 
puis le 'programme client' sur les machines clientes pour pouvoir faire fonctionner le systeme.

La plupart des fonctionnalités sont automatiques, pour plus d'informations voir le fichier 'README'
des répertoires 'serveur' et 'client'.

Librairies utilisées :
	Coté serveur :
		-sqlite3
		-gnuplot
		-netcat (nc)
	Coté client :
		-psutil (python)
		-netcat (nc)

Partie I - Collecte d'information
	Tâches réalisées :
	-Mettre en place au moins trois sondes collectant un ensemble d’informations sur
		le système : CPU / disque / RAM / nombre de process / nombre de users connecté
		... (3 points)

Partie II - Stockage & Collecte web
	Tâches réalisées :
	-Un moteur de stockage de données avec gestion d’historique (2 points)
	-Un parseur web ( http :// www . cert . ssi . gouv . fr / ) qui va récupéré la dernière alerte
		CERT et l’envoi au moteur de stockage (2 points)

	Tâches bonus réalisées :
	-L’utilisation de format standard ou d’un moteur de base de données sans serveur
	-Prévoir un cas de sauvegarde/restauration
	-L’ajout d’une nouvelle machine dans le réseaux ne nécessite pas de modification
		manuelle du code ou de la base.

Partie III - Affichage & alerte
	Tâches réalisées :
	-Un module de détection de situation de crise (1 point)
	-Un module d’envoi de mail (2 points)
	-Un module d’affichage (2 points)

Partie IV - Communication
	Tâches réalisées :
	-Un module qui attend les requêtes des sondes et les envoie vers le serveur (2
		points).
	-Un module qui récupère et sauvegarde les informations (1 points).

