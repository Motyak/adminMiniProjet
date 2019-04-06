import sqlite3
import datetime

LIMITE='0.95'

datetimeLimite=datetime.datetime.now()-datetime.timedelta(minutes=30)
dateLimite=datetimeLimite.strftime("%Y/%m/%d")
heureLimite=datetimeLimite.strftime("%H:%M:%S")

db=sqlite3.connect('bdd.db')
cursor=db.cursor()
#si une machine est en etat de crises pour une duree de plus de 30min, situation crise.
#permet d'afficher le nombre d'extraction en etat crise parmi les 6(*3) dernieres extractions de chaque machine
#machine|nbCrisesCpu|nbCrisesRam|nbCrisesDisk
print("select machine,type,info from EXTRACTION where date>='"+dateLimite+"' and heure>='"+heureLimite+"' and (type=cpuUsage or type=memUsage or type=diskUsage) and info>'"+LIMITE+"' group by machine")

