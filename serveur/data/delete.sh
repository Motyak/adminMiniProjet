#!/bin/sh

#supprime toutes les extractions datant de plus d'un mois
dateLimite=$(date +%Y/%m/%d -d "1 month ago")
sqlite3 bdd.db < "delete from EXTRACTION where date<'dateLimite'";