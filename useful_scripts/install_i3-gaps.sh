#!/bin/sh -e

# dependencies
sudo apt-get install libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb\
						libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev\
						libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev\
						libxcb-xinerama0-dev libxkbcommon-x11-dev\
						libstartup-notification0-dev libxcb-randr0-dev\
						libxcb-xrm0 libxcb-xrm-dev


mkdir -p $HOME/.compile
cd $HOME/.compile

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

autoreconf --force --install
mkdir -p build
cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers

make
sudo make install
