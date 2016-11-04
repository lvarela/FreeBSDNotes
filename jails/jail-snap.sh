#!/bin/sh

. ./functions.sh

d=$(date +%Y%m%d_%H%M)
zp=$(zpool list -H -o name | head -1)

echo "zfs snapshot $zp/jails/$1@$d"

