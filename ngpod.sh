#!/bin/bash

## Script to download NattyGeo Pic of Day
#   and set it as the wallpaper in afternoon

cd ~/Devel/ngpod/ngpics;

# ----------------------
# --- OPTIONS
# ----------------------
# set this to 'yes' to save description to ~/ngpod/description.txt from ngeo page
GET_DESCRIPTION="yes"

# save pics to this dir
PIX_DIR=~/Devel/ngpod/ngpics


# ----------------------
# --- FUNCTIONS
# ----------------------

function get_page {
  echo "Downloading page to find image..."
  wget -O http://photography.nationalgeographic.com/photography/photo-of-the-day/ --quiet
  grep -m http://images.nationalgeographic.com/.*.jpg -o > /tmp/pic_url
}

function clean_up {
  echo "Cleaning up temp files..."
  if [ -e "/tmp/pic_url" ]; then
    rm /tmp/pic_url
  fi
}

# -----------------------
# --- MAIN
# -----------------------
echo "--------------------"
echo "-- NGEO WALLPAPER --"
echo "--------------------"

# set date
TODAY=$(date +'%Y%m%d')

# if we don't have image already today
if [ ! -e ~/Devel/ngpod/ngpics/${TODAY}_ngeo.jpg ]; then
  echo "We don't have this pic saved, saving it..."
  get_page
  # got link to image
  PIXURL=`/bin/cat /tmp/pic_url`
  echo "Downloading image..."
  wget --quiet $PIXURL -O $PIX_DIR/${TODAY}_ngeo.jpg

# else if we have it, is it the newest copy???
else
  get_page

  # Got link to image
  PIXURL=`/bin/cat /tmp/pic_url`
  echo "Picture URL is: ${PIXURL}"

  # get filesize
  SITEFILESIZE=$(wget --spider $PICURL 2>&1 | grep Length | awk '{print $2}')
  FILEFILESIZE=$(stat -c %s $PIX_DIR/${TODAY}_ngeo.jpg)

  # if the pix has been updated
  if [ $SITEFILESIZE != $FILEFILESIZE ]; then
    echo "The pix has been updated, getting updated copy"
    rm $PIX_DIR/${TODAY}_ngeo.jpg

    # got the link to the image
    PICURL=`/bin/cat /tmp/pic_url`
    echo "Downloading image..."
    wget --quiet $PICURL -O $PIX_DIR/${TODAY}_ngeo.jpg

  # if the pix is the same
  else
    echo "Picture is the same, finishing up..."
  fi
fi

clean_up


osascript -e 'tell application "Finder" to set desktop picture to "Macintosh HD:Users:davidr:Devel:ngpod:ngpics:${TODAY}_ngeo.jpg" as alias';

killall Dock;
