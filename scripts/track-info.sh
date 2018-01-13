#!/bin/bash
title=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|grep -A 1 "title"|grep -v "title"|cut -b 44-|cut -d '"' -f 1|grep -v ^$`
artist=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|grep -A 2 "artist"|grep -v "artist"|grep -v "array"|cut -b 27-|cut -d '"' -f 1|grep -v ^$`
divide=': '
N=33
MIN=5
empty="Unknown"
full=$artist$divide$title
length=${#full}

if [ $length -lt $MIN ]
	then
		title=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.rhythmbox /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 "xesam:title" | grep  -v "array \[" | cut -b 43- | grep -v ":title" | sed -e 's/^"//' -e 's/"$//'`
		artist=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.rhythmbox /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 "xesam:albumArtist" | grep  -v "array \[" | cut -b 26- | grep -v ":albumArtist" | sed -e 's/^"//' -e 's/"$//'`
		if [ ${#artist} -eq 0 ]
			then
				if [ ${#title} -ne 0 ]
					then
						artist=$empty
				fi
		fi
		full=$artist$divide$title
		length=${#full}
fi

if [ $length -gt $N ]
	then
		full="${full:0:N}..."
fi
echo $full
