#!/bin/bash

sleep 5			# allow time for the network settings to load at boot

SCHOME=/home/user/share/wallpaper  # edit user name
BGFILE=$SCHOME/sys.info
BG=$SCHOME/bg.png
ORIGWALL=/usr/share/backgrounds/backup/default.png
NEWWALL=$SCHOME/wallpaper.png
WALL=/usr/share/backgrounds/default.png

> $BGFILE

 
B_HOSTNAME=`hostname`
B_IPADDRESS=`/sbin/ifconfig | grep inet | grep -v 127.0.0.1 | gawk '{print $2}' | gawk -F":" '{print $2}'`

echo   Project Name >> $BGFILE # edit project name
echo  $B_HOSTNAME >> $BGFILE
echo  $B_IPADDRESS >> $BGFILE


cat $BGFILE | \
convert -font Century-Schoolbook-Roman -pointsize 60 \
        -background none \
        -fill white \
		-gravity center \
        label:@- $BG 
 
composite -gravity center $BG $ORIGWALL $NEWWALL
cp $NEWWALL $WALL

gconftool-2 --type string --set /desktop/gnome/background/picture_filename /home/user/share/wallpaper/wallpaper.png # edit user name
