#!/bin/sh

#  CreateIcns.command
#  
#
#  Created by Thomas Varano on 2/21/18.
#
read -p "Current Folder: /Users/${USER}/" home
cd "/Users/${USER}/${home}"
read -p "Name of icon (include png) " icon
read -p "Desired iconset name " name

mkdir $name.iconset

sips -z 16 16 $icon --out $name.iconset/icon_16x16.png
sips -z   32   32 $icon --out $name.iconset/icon_16x16@2x.png
sips -z   32   32 $icon --out $name.iconset/icon_32x32.png
sips -z  128  128 $icon --out $name.iconset/icon_32x32@2x.png
sips -z  128  128 $icon --out $name.iconset/icon_128x128.png
sips -z  256  256 $icon --out $name.iconset/icon_128x128@2x.png
sips -z  256  256 $icon --out $name.iconset/icon_256x256.png
sips -z  512  512 $icon --out $name.iconset/icon_256x256@2x.png
sips -z  512  512 $icon --out $name.iconset/icon_512x512.png
sips -z 1024 1024 $icon --out $name.iconset/icon_512x512@2x.png
iconutil --convert icns $name.iconset
mkdir -p package/macosx
cp $name.icns package/macosx
echo 'icon created'
