#!/bin/sh

#installation directory absolute path
readonly DRY="/usr/local/bin/miniProjet"

filename=$(date +"%d-%m-%Y_%H-%M-%S")
cp $DRY/bdd.db $DRY/.backup/$filename