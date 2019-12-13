#!/bin/bash

HOST="192.168.43.1:2547"         
LCD="/mnt/Download/"    #Local directory
RCD="/device/Download/" #FTP directory

clear


echo "verificando instalacao lftp"
which lftp &> /dev/null  

if [ $? -ne 0 ];
then
    sudo apt-get install -y lftp
fi


read -p "Deseja sincronizacao reversa? (comp>>device: y/n):" -n 1 -r
echo # (opticional) mover para proxima linha
if [[ $REPLY =~ ^[Yy]$ ]] 
then
    lftp -f "
    set ftp:use-allo false
    debug -o debug.text 9
    open $HOST
    mirror --continue --delete --reverse $LCD $RCD
    exit
    " 
else
    lftp -f "
    debug -o debug.text 9
    open $HOST
    mirror --continue --delete $RCD $LCD
    exit
    " 
fi
echo "sincronizacao concluida"
echo
