#!/usr/local/bin/bash

. ./functions.sh

#TODO: use argument from cmd line
zpool='zroot'
pool_cmd="zfs create -o mountpoint=/usr/local/jails $zpool/jails"
pool_comp="zfs set compression=lz4 $zpool/jails"

ask "Create ZFS pool ($zpool/jails)?" "$pool_cmd" 
ask "Activate compression (lz4) on pool?" "$pool_comp" 

echo "Fetchig FreeBSD release into /tmp/ ..."

fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/11.0-RELEASE/base.txz -o /tmp/base.txz
fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/11.0-RELEASE/lib32.txz -o /tmp/lib32.txz
fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/11.0-RELEASE/ports.txz -o /tmp/ports.txz


#ask "Create jail.conf? [This action will overwrite the file]"  "use_template ./jail-init.template > /etc/jail.conf" 
cp /etc/jail.conf /etc/jail.conf.bak
use_template ./jail-init.template > /etc/jail.conf

echo "Jail initialization done. You can create jails now with jail-create.sh"

