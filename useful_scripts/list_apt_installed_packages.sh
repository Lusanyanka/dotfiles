#!/bin/bash

if [ -e /var/log/apt/history.log.1.gz ]; then
	zcat /var/log/apt/history.log.*.gz |\
		cat - /var/log/apt/history.log |\
		grep -oP '^Commandline: apt(|-get) install (?!.*--reinstall)\K.*'
else
	cat /var/log/apt/history.log |\
		grep -oP '^Commandline: apt(|-get) install (?!.*--reinstall)\K.*'
fi
