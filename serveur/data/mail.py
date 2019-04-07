import sys
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

if(len(sys.argv)!=3):
    print("Usage : mail.py *ipMachine* *valeurMesure*")
    sys.exit(0)



mail_content = "La machine qui a pour adresse ip "+sys.argv[1]+" a utilisé "+sys.argv[2]+"% de l'espace stockage de son disque principal !"
#The mail addresses and password
sender_address = 'paninijambonfromage@gmail.com'
sender_pass = 'pan1n1jambonfromage#'
receiver_address = 'motyakskellington@gmail.com'
#Setup the MIME
message = MIMEMultipart()
message['From'] = sender_address
message['To'] = receiver_address
message['Subject'] = 'SITUATION DE CRISE ESPACE DISQUE'
#The body and the attachments for the mail
message.attach(MIMEText(mail_content, 'plain'))
#Create SMTP session for sending the mail
session = smtplib.SMTP('smtp.gmail.com', 587) #use gmail with port
session.starttls() #enable security
session.login(sender_address, sender_pass) #login with mail_id and password
text = message.as_string()
session.sendmail(sender_address, receiver_address, text)
session.quit()
print('Mail Sent')