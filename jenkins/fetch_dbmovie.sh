#!/bin/bash

# récupérer le fichier sql de github
git clone -b ora-nodocker https://github.com/matthcol/dbmovie

# envoyer le fichier sql à VM Database Oracle
# une fois VM Repository créée, ce fichier sera envoyé à VM Repository
# puis récupéré par VM Deploy Ansible et envoyé à VM Database

cd dbmovie/
scp -r sql 192.168.186.145:/home/user1/database



