
#!/bin/bash
#By Thomas Varano

echo 'Prerequisites:'
echo -e '\tBe in the correct folder. Have a jar titled in the format "<name>-<version>.jar"'
echo -e '\tHave all resources in the folder'
echo -e '\tNO SPACES. Use Dashes (-)'
echo
echo 'Type "q" to quit'
read -p 'Directory containing contents: /Users/'${USER}'/' home
if [ $home = 'q' ]
then
echo 'exit'
exit
fi
    cd "/Users/${USER}/${home}"
echo 'Use dashes instead of spaces'
read -p 'Application Name: ' name
read -p 'Version: ' version
read -p 'Icon name (must be .png, include suffix): ' icon
read -p 'Class with main method (if using packages, include full reference): ' class
read -p 'Continue? (y : n): ' cont
if [ $cont = 'n' ]
then
    echo 'exit'
    exit
fi
echo
name=${name// /-}

# Create the icon set
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
echo

# Export the application
# change -native <type> to be whatever desired supported export format
jdk=$(/usr/libexec/java_home)
$jdk/bin/javapackager -deploy -native dmg -name ${name}-${version} \
-BappVersion=$version -Bicon=package/macosx/$name.icns \
-srcdir . -srcfiles $name.jar -appclass $class \
-outdir out -v
suffix=$type

echo 'DONE'
exit 0
