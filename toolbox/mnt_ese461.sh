#!/bin/sh

if [ $# -eq 1 ] && [ "$1" = "umount" ] && [ -d ese461 ]; then
	fusermount -o nonempty -u ese461
	exit $?
fi

mkdir -p ese461
sshfs shell:workspace/ese461 ./ese461
