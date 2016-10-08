#!/usr/local/bin/bash

############################
#Run after jails-init.sh
############################

jail=$1
ip=$2
rel='10.3-RELEASE'


use_template() {
  eval "echo \"$(cat $1)\""
}

zfs create zroot/jails/$jail

tar -xvf /tmp/base.txz -C /usr/local/jails/$jail
tar -xvf /tmp/lib32.txz -C /usr/local/jails/$jail
tar -xvf /tmp/ports.txz -C /usr/local/jails/$jail

echo "Updating release on $jail [freebsd-update]"
env UNAME_r=$rel freebsd-update -b /usr/local/jails/$jail fetch install

echo "Checking release on $jail"
env UNAME_r=$rel freebsd-update -b /usr/local/jails/$jail IDS

cp /etc/resolv.conf /usr/local/jails/$jail/etc/
echo hostname=\"$jail\" > /usr/local/jails/$jail/etc/rc.conf

#write to /etc/jail.conf
jail_name=$1
jail_ip=$2
jail_inter=$3

use_template ./jail-create.template >> /etc/jail.conf




