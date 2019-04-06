import xml.etree.ElementTree as ET
import sqlite3
import urllib.request
import os
import sys

MONTHS = {'Jan' : '01', 'Feb' : '02', 'Mar' : '03', 'Apr' : 'O4', 'May' : '05',
'Jun' : '06', 'Jul' : '07','Aug' : '08','Sep' : '09','Oct' : '10','Nov' : '11','Dec' : '12'}

#installation directory absolute path
DRY='/usr/local/bin/miniProjet'

#telechargement du fichier xml
urllib.request.urlretrieve('https://www.cert.ssi.gouv.fr/alerte/feed/',DRY+'/alertes.xml')

#parsing des infos
lastItem = ET.parse(DRY+'/alertes.xml').getroot().find('channel').find('item')
title=lastItem.find('title').text
date=lastItem.find('pubDate').text
link=lastItem.find('link').text

s1=date.split(' ')
heure=s1[4]
date_f=s1[3]+'/'+MONTHS[s1[2]]+'/'+s1[1]

#verification si alerte deja stockee
db=sqlite3.connect(DRY+'/bdd.db')
cursor=db.cursor()
cursor.execute('select titre from ALERTE order by date desc, heure desc limit 1')
if(cursor.fetchone() is not None):
	if(cursor.fetchone() == title):
		os.remove(DRY+'/alertes.xml')
		sys.exit(0)
	os.remove(DRY+'/alertes.xml')
#si aucune alerte stocke
else:
    # insertion de l'alerte
    cursor.execute('''insert into ALERTE values(null,?,?,?,?)''',(title,date_f,heure,link))
    db.commit()
    db.close()
    os.remove(DRY+'/alertes.xml')
