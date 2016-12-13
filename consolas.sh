#!/bin/sh

# Shamelessly stolen from Sup's wiki:
# http://ssup2.iptime.org/wiki/Ubuntu_Consolas_Font_Install

set -e
set -x
mkdir temp
cd temp
wget http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe
cabextract -L -F ppviewer.cab PowerPointViewer.exe
cabextract ppviewer.cab
