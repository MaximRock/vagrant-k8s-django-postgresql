#!/bin/bash
set -e

PATH_FOLDER=$HOME/github/vagrant-k8s-django-postgresql/src
NAME_FOLDER=mykeys
FOLDER=$PATH_FOLDER/$NAME_FOLDER

if [ ! -d $FOLDER ]
then
    mkdir $FOLDER 2>&1
    cd $FOLDER

    ssh-keygen -m PEM -t ed25519 -b 4096 -f myansible.key -N "" -C "root@srv" 2>&1

else
    cd $PATH_FOLDER
    rm -rf $FOLDER

fi    

vagrant up



