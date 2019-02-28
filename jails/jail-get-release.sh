#!/bin/sh

if [ $# -ne 1 ]; then
    echo " "
	echo "--- :: [Wrong number of arguments] :: ---"
    echo " "
	echo " Usage:   $0 [release]"
	echo " Example: $0 12.0-RELEASE-p1"
    echo " "
	exit
fi

echo "Fetchig FreeBSD release into /tmp/ ..."

fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/$1/base.txz -o /tmp/$1-base.txz
fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/$1/lib32.txz -o /tmp/$1-lib32.txz
fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/$1/ports.txz -o /tmp/$1-ports.txz

echo "Release ready for jails."

