#!/usr/local/bin/bash

#Customize this for your needs
zpool='zroot'


pool_cmd='zfs create -o mountpoint=/usr/local/jails $zpool/jails'
pool_comp='zfs set compression=lz4 $zpool/jails'

while true; do
    read -p "Create ZFS pool ($zpool/jails)? [y/n]?" yn
    case $yn in
        [Yy]* ) eval "$pool_cmd"; break;;
        [Nn]* ) exit;;
    * ) echo "Please answer [y]es or [n]o.";;
    esac
done

while true; do
    read -p "Activate compression (lz4) on pool? [y/n]?" yn
    case $yn in
        [Yy]* ) eval "$pool_comp"; break;;
        [Nn]* ) exit;;
    * ) echo "Please answer [y]es or [n]o.";;
    esac
done




fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/10.3-RELEASE/base.txz -o /tmp/base.txz
fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/10.3-RELEASE/lib32.txz -o /tmp/lib32.txz
fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/10.3-RELEASE/ports.txz -o /tmp/ports.txz
