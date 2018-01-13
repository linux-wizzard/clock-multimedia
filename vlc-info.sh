#!/bin/bash
video=''
N=33
MIN=5
full=$video
length=${#full}

if [ $length -lt $MIN ]
	then
		full=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 "xesam:title" | grep  -v "array \[" | cut -b 43- | grep -v ":title" | sed -e 's/^"//' -e 's/"$//'`

		if [ ${#full} -eq 0 ]
			then
				full=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 2 "xesam:url" | grep  -v "array \[" | cut -b 51- | grep -v ":title" | sed -e 's/^"//' -e 's/"$//' | grep -oP "\w[^/]*[^/]$"`
		fi
						
		length=${#full}
fi

if [ $length -gt $N ]
	then
		full="${full:0:N}..."
fi
echo $full
