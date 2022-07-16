#!/bin/sh

# You should remember to add the non-free packages to the apt list

sudo dpkg --add-architecture i386
sudo aptitude update
sudo aptitude install steam
