import sqlite3
import datetime
import os

#situation de crise : si le disque dur principal d'une machine depasse les 95% d'utilisation

#installation directory absolute path
DRY='/usr/local/bin/miniProjet'

LIMITE=95.0

datetimeAuj=datetime.datetime.now()
dateAuj=datetimeAuj.strftime("%Y/%m/%d")
heureAuj=datetimeAuj.strftime("%H:%M:%S")

datetimeLimite=datetimeAuj-datetime.timedelta(minutes=5)
dateLimite=datetimeLimite.strftime("%Y/%m/%d")
heureLimite=datetimeLimite.strftime("%H:%M:%S")

db=sqlite3.connect(DRY+'/bdd.db')
cursor=db.cursor()
res=cursor.execute('''select distinct machine,info from EXTRACTION where date>=? and heure>=? and type='diskUsage' and info>?''',(dateLimite,heureLimite,LIMITE))
# Pour chaque entree de la list : envoyer mail de crise de type disk avec ip de la machine et pourcentage disk usage
for row in res:
    cursor.execute("select count(machine) from CRISE where machine='"+row[0]+"' limit 1")
    #si la crise n'a pas deja ete enregistree
    if(cursor.fetchone()[0]==0):
        cursor.execute('''insert into CRISE values(null,?,?,?,?,?)''',(row[0],'diskUsage',str(row[1]),dateAuj,heureAuj))
        db.commit()
        os.system("python3 "+DRY+"/mail.py "+row[0]+" "+str(row[1]))
db.close()
