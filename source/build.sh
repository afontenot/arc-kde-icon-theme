#!/usr/bin/env zsh

export pkgname="arc-kde-icon-theme"
export arc="arc-icon-theme"
export arc_v="20161122"
export breeze="breeze-icons"
export breeze_v="5.56.0"
export papirus="papirus-icon-theme"
export papirus_v="20190302"

# download
wget https://github.com/horst3180/arc-icon-theme/archive/$arc_v.tar.gz
wget https://download.kde.org/stable/frameworks/5.56/$breeze-$breeze_v.tar.xz
wget https://github.com/PapirusDevelopmentTeam/$papirus/archive/$papirus_v.tar.gz

# extract
tar xf $arc_v.tar.gz
tar xf $breeze-$breeze_v.tar.xz
tar xf $papirus_v.tar.gz

# prepare
mv $arc-$arc_v $pkgname
cp -a $breeze-$breeze_v/icons/applets $pkgname/Arc
rm $breeze-$breeze_v/icons/apps/48/audacity.svg
rm $breeze-$breeze_v/icons/apps/48/darktable.svg
rm $breeze-$breeze_v/icons/apps/48/gimp.svg
rm $breeze-$breeze_v/icons/apps/48/handbrake.svg
rm $breeze-$breeze_v/icons/apps/48/inkscape*
rm $breeze-$breeze_v/icons/apps/48/keepass*
rm $breeze-$breeze_v/icons/apps/48/libreoffice*
rm $breeze-$breeze_v/icons/apps/48/mpv.svg
rm $breeze-$breeze_v/icons/apps/48/system-file-manager.svg
rm $breeze-$breeze_v/icons/apps/48/VBox.svg
rm $breeze-$breeze_v/icons/apps/48/virtualbox.svg
rm $breeze-$breeze_v/icons/apps/48/vlc.svg
cp -an $breeze-$breeze_v/icons/apps/48 $pkgname/Arc/apps
rm $breeze-$breeze_v/icons/apps/64/system-file-manager.svg
cp -an $breeze-$breeze_v/icons/apps/64 $pkgname/Arc/apps
cp -an $breeze-$breeze_v/icons/categories $pkgname/Arc
cp -an $breeze-$breeze_v/icons/devices/64/media-optical* $pkgname/Arc/devices/64
cp -a $breeze-$breeze_v/icons/emotes $pkgname/Arc
cp -a $breeze-$breeze_v/icons/preferences $pkgname/Arc
cp -a $breeze-$breeze_v/icons/status/64/dialog-password.svg $pkgname/Arc/status/64
rm -r $breeze-$breeze_v/icons/status/64
cp -an $breeze-$breeze_v/icons/status $pkgname/Arc

# fix ups (for missing icons, etc)
ln -s ../../places/48/folder.png $pkgname/Arc/apps/48/system-file-manager.png
ln -s ../../places/64/folder.png $pkgname/Arc/apps/64/system-file-manager.png
cp -an custom/* $pkgname/Arc
for dir in $pkgname/Arc/mimetypes/*; do
    rm $dir/image-x-generic.png;
    rm $dir/video-x-generic.png;
    ln -s ./audio-x-generic.png $dir/application-vnd.apple.mpegurl;
    ln -s ./text-x-preview.png $dir/none.png;
    ln -s ./text-x-preview.png $dir/application-x-zerosize.png;
    ln -s ./text-x-preview.png $dir/unknown.png;
    ln -s ../../categories/$(basename $dir)/applications-internet.png $dir/application-x-mswinurl.png;
    cp -an $papirus-$papirus_v/Papirus/64x64/apps/multimedia-photo-viewer.svg $pkgname/Arc/mimetypes/$(basename $dir)/image-x-generic.svg;
    cp -an $papirus-$papirus_v/Papirus/64x64/apps/com.github.artemanufrij.playmyvideos.svg $pkgname/Arc/mimetypes/$(basename $dir)/video-x-generic.svg;
done
for dir in $papirus-$papirus_v/Papirus/*; do
    realdir=$(echo $(basename $dir) | sed -r 's/x[0-9]+//g');
    cp $dir/mimetypes/*pkcs* $pkgname/Arc/mimetypes/$realdir;
    cp $dir/mimetypes/*pem* $pkgname/Arc/mimetypes/$realdir;
    cp $dir/mimetypes/*cert* $pkgname/Arc/mimetypes/$realdir;
    cp $dir/mimetypes/*pgp* $pkgname/Arc/mimetypes/$realdir;
    cp $dir/mimetypes/application-x-fictionbook.svg $pkgname/Arc/mimetypes/$realdir;
    ln -s ./application-x-fictionbook.svg $pkgname/Arc/mimetypes/$realdir/application-x-mobi8-ebook.svg;
    ln -s ./application-x-fictionbook.svg $pkgname/Arc/mimetypes/$realdir/application-epub+zip.svg;
    ln -s ./application-pgp-signature.svg $pkgname/Arc/mimetypes/$realdir/application-vnd.ms-publisher.svg;
done

# create build directory in parent folder
mv $pkgname/Arc ../Arc-Kde
cp configure.ac ..
cp Makefile.am ..
cp index.theme ../Arc-Kde
cp $pkgname/autogen.sh ..

# cleanup
rm -r $breeze-$breeze_v
rm $breeze-$breeze_v.tar.xz
rm $arc_v.tar.gz
rm -r $papirus-$papirus_v
rm $papirus_v.tar.gz
rm -r $pkgname

