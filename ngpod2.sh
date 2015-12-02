#!/bin/sh
cd
curl -OLs "http://photography.nationalgeographic.com/photography/photo-of-the-day"
curl -Os $( grep -m 1 "width=\"990\"" photo-of-the-day | cut -d"\"" -f2 | sed 's/^..//')
PTH=$(ls *.jpg)
mv $PTH ~/Devel/ngpod/ngpics/
cd ~/Devel/ngpod/ngpics/
osascript -e 'tell app "Finder" to set desktop picture to POSIX file "'"$(ls -d -1 $PWD/$PTH)"\"
cd
rm photo-of-the-day
