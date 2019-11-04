
#!/bin/bash
#By Thomas Varano

echo 'Prerequisites:'
echo -e '\tBe in the correct folder. Have a jar titled in the format "<name>-<version>.jar"'
echo -e '\tHave all resources in the folder'
echo -e '\tNO SPACES. Use Dashes (-)'
echo
echo 'Type "cmd+c" to quit at any time'
read -p 'Directory containing contents: /Users/'${USER}'/' home

    cd "/Users/${USER}/${home}"

read -p 'Application Name: ' NAME
read -p 'Version: ' VERSION
read -p 'Icon name (must be .png, include suffix): ' ICON
read -p 'Class with main method (if using packages, include full reference): ' CLASS

read -p 'Continue? (y : n): ' cont
if [ $cont = 'n' ]
then
    echo 'exit'
    exit
fi
echo

# Create the icon set
mkdir ${NAME}.iconset

sips -z 16 16 '${ICON}' --out '${NAME}.iconset/icon_16x16.png'
sips -z   32   32 '${ICON}' --out '${NAME}.iconset/icon_16x16@2x.png'
sips -z   32   32 '${ICON}' --out '${NAME}.iconset/icon_32x32.png'
sips -z  128  128 '${ICON}' --out '${NAME}.iconset/icon_32x32@2x.png'
sips -z  128  128 '${ICON}' --out '${NAME}.iconset/icon_128x128.png'
sips -z  256  256 '${ICON}' --out '${NAME}.iconset/icon_128x128@2x.png'
sips -z  256  256 '${ICON}' --out '${NAME}.iconset/icon_256x256.png'
sips -z  512  512 '${ICON}' --out '${NAME}.iconset/icon_256x256@2x.png'
sips -z  512  512 '${ICON}' --out '${NAME}.iconset/icon_512x512.png'
sips -z 1024 1024 '${ICON}' --out '${NAME}.iconset/icon_512x512@2x.png'
iconutil --convert icns '${NAME}.iconset'
mkdir -p package/macosx
cp '${NAME}.icns' package/macosx
echo 'icon created'
echo

# Export the application
# change -native <type> to be whatever desired supported export format
jdk=$(/usr/libexec/java_home)
$jdk/bin/javapackager -deploy -native dmg -name '${NAME}-${VERSION}' \
-BappVersion='${VERSION} -Bicon='package/macosx/${NAME}.icns' \
-srcdir . -srcfiles '${NAME}.jar' -appclass '${CLASS}' \
-outdir out -v

echo 'DONE'
exit 0
