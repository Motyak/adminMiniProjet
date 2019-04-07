#!/bin/sh

#installation directory absolute path
readonly DRY="/usr/local/bin/miniProjet"

#supprime toutes les extractions datant de plus d'un mois
dateLimite=$(date +%Y/%m/%d -d "1 month ago")
sqlite3 $DRY/bdd.db "delete from EXTRACTION where date<'$dateLimite'";

#supprime toutes les crises datant de plus de 24h
dateLimite=$(date +%Y/%m/%d -d "yesterday")
heureLimite=$(date "+%H:%M:%S")
sqlite3 $DRY/bdd.db "delete from CRISE where date<'$dateLimite' and heure<'$heureLimite'";