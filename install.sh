#!/bin/bash
mkdir ~/.conky/clock-multimedia
chmod +x scripts/track-info.sh scripts/vlc-info.sh
chmod +x uninstall.sh
cp clock-widget ~/.conky/clock-multimedia
cp -rf icons ~/.conky/clock-multimedia
cp -rf scripts ~/.conky/clock-multimedia
yes | cp clock-widget ~/.conkyrc
