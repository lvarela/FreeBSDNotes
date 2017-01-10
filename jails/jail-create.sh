#!/bin/sh
############################
#Run after jails-init.sh
############################

. ./functions.sh


if [ $# -ne 3 ]; then
	echo "--- :: [Wrong number of arguments] :: ---"
	echo " Usage: $0 [jailname] [network interface] [ip]"
	echo " Example: $0 myjail em0 192.168.0.2"
	echo "---                                   ---"
	exit
fi

jail=$1
#ip=$2
#rel='11.0-RELEASE-p1'
rel=$(freebsd-version)

zpool=$(zpool list -H -o name | head -1)

zfs create $zpool/jails/$jail
echo "Created zpool/jails/$jail pool."

#delete_ports="rm -rf /usr/local/jails/$jail/usr/ports"
ports_cmd="tar -xf  /tmp/ports.txz -C /usr/local/jails/$jail --totals"
lib32_cmd="tar -xf  /tmp/ports.txz -C /usr/local/jails/$jail --totals"
upd_cmd="env UNAME_r=$rel freebsd-update -b /usr/local/jails/$jail fetch install"
start_shell="jexec $jail"

echo "Uncompressing release on /usr/local/jails/$jail..."
tar -xf  /tmp/base.txz -C /usr/local/jails/$jail  --totals
ask "Do you need lib32 compatability?" "$lib32_cmd" 
ask "Do you need the ports tree? (~1GB)" "$ports_cmd" 
ask "Run freebsd-update on jail?" "$upd_cmd" 

#env UNAME_r=$rel freebsd-update -b /usr/local/jails/$jail IDS

cp /etc/resolv.conf /usr/local/jails/$jail/etc/
echo hostname=\"$jail\" > /usr/local/jails/$jail/etc/rc.conf

#variables used in jail.conf template
jail_name=$1
jail_inter=$2
jail_ip=$3

#write to /etc/jail.conf
use_template ./jail-create.template >> /etc/jail.conf

echo "Jail created."

#start jail
jail -c $jail

ask "Start a shell on $jail [y/n]" "$start_shell"
