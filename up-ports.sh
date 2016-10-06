#!/usr/local/bin/bash

upcmd='portupgrade -a'

svn up /usr/ports

portmaster -L | grep New > up-ports.txt

cat up-ports.txt

while true; do
    read -p "Upgrade all ports [y/n]?" yn
    case $yn in
        [Yy]* ) eval "$upcmd"; break;;
        [Nn]* ) exit;;
    * ) echo "Please answer [y]es or [n]o.";;
    esac
done
