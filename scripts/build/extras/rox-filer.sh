VERSION=${VERSION-2.11}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libglade" "shared-mime-info"

rget "http://downloads.sourceforge.net/rox/rox-filer-$VERSION.tar.bz2"\
    "ftp://ftp.openbsd.cl/ports/distfiles/rox-filer-$VERSION.tar.bz2"
rm -rf rox-filer-$VERSION && tar -jxf "rox-filer-$VERSION.tar.bz2"
rm -f "rox-filer-$VERSION.tar.bz2"
cd rox-filer-$VERSION

cd ROX-Filer
sed -i "s:g_strdup(getenv(\"APP_DIR\")):\"$PREFIX/share/rox\":" src/main.c

mkdir build
pushd build
    ../src/configure --prefix=$PREFIX LIBS="-lm -ldl"
    make
popd

mkdir -p $PREFIX/share/rox
cp -av Help Messages Options.xml ROX images style.css .DirIcon $PREFIX/share/rox

cp -av ../rox.1 $PREFIX/share/man/man1
cp -v  ROX-Filer $PREFIX/bin/rox
chown -Rv root:root $PREFIX/bin/rox $PREFIX/share/rox

cd $PREFIX/share/rox/ROX/MIME
ln -svf text-x-{diff,patch}.png
ln -svf application-x-font-{afm,type1}.png
ln -svf application-xml{,-dtd}.png
ln -svf application-xml{,-external-parsed-entity}.png
ln -svf application-{,rdf+}xml.png
ln -svf application-x{ml,-xbel}.png
ln -svf application-{x-shell,java}script.png
ln -svf application-x-{bzip,xz}-compressed-tar.png
ln -svf application-x-{bzip,lzma}-compressed-tar.png
ln -svf application-x-{bzip-compressed-tar,lzo}.pn
ln -svf application-x-{bzip,xz}.png
ln -svf application-x-{gzip,lzma}.png
ln -svf application-{msword,rtf}.png
