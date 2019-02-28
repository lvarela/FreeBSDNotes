#!/usr/local/bin/bash
############################
#Run after jails-init.sh
############################

. ./functions.sh

if [ $# -ne 4 ]; then
    echo ""
	echo "---------------------------------------------         "
	echo "                                                      "
	echo " [ Jail Management Toolbox | Create jail ]            "
	echo "                                                      "
	echo " Usage: $0 [jailname] [network interface] [ip]        "
	echo " Example use: $0 myjail em0 192.168.0.2 12.0-RELEASE  "
	echo "                                                      "
	echo "---------------------------------------------         "
    echo ""
	exit
fi

jail=$1
rel=$4
zpool=($(zpool list -H -o name))

dialog_select "Jails" "Select a zpool:" zpool 
res=$(cat /tmp/jms-res.temp)
echo "$res"

mountpoint=($(zfs list -H -o mountpoint $res))

pool_cmd = "zfs create $res/jails/$jail"
#non_pool_cmd = "mkdir -p -v $mountpoint/jails/$jail"

ask "Create a ZFS pool for the jail?" "$pool_cmd"

#Make sure the directory is created
mkdir -p -v $mountpoint/jails/$jail
#echo "Created $res/jails/$jail pool."

ports_cmd="tar -xf /tmp/$rel-ports.txz -C $mountpoint/jails/$jail --totals"
lib32_cmd="tar -xf /tmp/$rel-lib32.txz -C $mountpoint/jails/$jail --totals"
upd_cmd="env UNAME_r=$rel freebsd-update -b /usr/local/jails/$jail fetch install"
start_shell="jexec $jail"

echo "Uncompressing release on $mountpoint/jails/$jail ..."
tar -xf  /tmp/$rel-base.txz -C $mountpoint/jails/$jail  --totals
ask "Do you need lib32 compatability?" "$lib32_cmd" 
ask "Do you need the ports tree? (~1GB)" "$ports_cmd" 
ask "Run freebsd-update on jail?" "$upd_cmd" 

#env UNAME_r=$rel freebsd-update -b $mountpoint/jails/$jail IDS

cp /etc/resolv.conf $mountpoint/jails/$jail/etc/
echo hostname=\"$jail\" > $mountpoint/jails/$jail/etc/rc.conf

#variables used in jail.conf template
jail_name=$1
jail_inter=$2
jail_ip=$3

#write to /etc/jail.conf
use_template ./jail-create.template >> /etc/jail.conf

echo "Jail created."

#start jail
jail -c $jail

ask "Start a shell on $jail " "$start_shell"
