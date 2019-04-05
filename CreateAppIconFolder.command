#!/bin/sh

#  CreateAppIconFolder.sh
#  
#
#  Created by Thomas Varano on 10/15/18.
#  
#!/bin/sh

read -p "Current Folder: /Users/${USER}/" HOME
cd "/Users/${USER}/${HOME}"
read -p "Name of icon (EXCLUDE suffix) " ICON
read -p "is your file .jpg? [y or n] " SUFF
if [ SUFF == "y" ]
then
    sips -s format png ${ICON}.jpg --out ${ICON}.png
fi

sips --matchTo '/System/Library/ColorSync/Profiles/sRGB Profile.icc' ${ICON}.png --out ${ICON}.png

mkdir ${ICON}\ iconset

sips -z   20   20 ${ICON}.png --out ${ICON}\ iconset/icon_20x20@1x.png
sips -z   40   40 ${ICON}.png --out ${ICON}\ iconset/icon_20x20@2x.png
sips -z   60   60 ${ICON}.png --out ${ICON}\ iconset/icon_20x20@3x.png
sips -z   29   29 ${ICON}.png --out ${ICON}\ iconset/icon_29x29@1x.png
sips -z   58   58 ${ICON}.png --out ${ICON}\ iconset/icon_29x29@2x.png
sips -z   87   87 ${ICON}.png --out ${ICON}\ iconset/icon_29x29@3x.png
sips -z   40   40 ${ICON}.png --out ${ICON}\ iconset/icon_40x40@1x.png
sips -z   80   80 ${ICON}.png --out ${ICON}\ iconset/icon_40x40@2x.png
sips -z  120  120 ${ICON}.png --out ${ICON}\ iconset/icon_40x40@3x.png
sips -z  120  120 ${ICON}.png --out ${ICON}\ iconset/icon_60x60@2x.png
sips -z  180  180 ${ICON}.png --out ${ICON}\ iconset/icon_60x60@3x.png
sips -z  76  76 ${ICON}.png --out ${ICON}\ iconset/icon_76x76@1x.png
sips -z 152 152 ${ICON}.png --out ${ICON}\ iconset/icon_76x76@2x.png
sips -z 167 167 ${ICON}.png --out ${ICON}\ iconset/icon_83.5x83.5@2x.png
sips -z 1024 1024 ${ICON}.png --out ${ICON}\ iconset/icon_1024x1024@1x.png

echo
echo 'icon created. safe to close.'
echo
