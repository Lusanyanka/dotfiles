#!/bin/sh

if [ "$1" = "install" ]; then
	apt-get update
	apt-get upgrade
	apt-get dist-upgrade
	cmd="apt-get install"
else
	cmd="-I @ echo @"
fi

cat pkg_list | grep -vP '(^\s*#|^$)' | xargs $cmd
