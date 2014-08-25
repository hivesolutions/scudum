VERSION=${VERSION-2.17}

wget -q --no-check-certificate "http://ftp.gnu.org/gnu/glibc/glibc-$VERSION.tar.xz"
rm -rf glibc-$VERSION && tar -Jxf "glibc-$VERSION.tar.xz"
rm -f "glibc-$VERSION.tar.xz"
cd glibc-$VERSION

cd ..
rm -rf glibc-build
mkdir glibc-build
cd glibc-build

../glibc-$VERSION/configure\
    --prefix=/usr\
    --disable-profile\
    --enable-kernel=2.6.25\
    --libexecdir=/usr/lib/glibc

make
make -k check 2>&1 | tee glibc-check-log
grep Error glibc-check-log

touch /etc/ld.so.conf
make install

# installs nis and rpc related headers that are
# not installed by default
cp -v ../glibc-$VERSION/sunrpc/rpc/*.h /usr/include/rpc
cp -v ../glibc-$VERSION/sunrpc/rpcsvc/*.h /usr/include/rpcsvc
cp -v ../glibc-$VERSION/nis/rpcsvc/*.h /usr/include/rpcsvc

# defines the the various locales that are going
# ot be used by the base libraries compilation
mkdir -pv /usr/lib/locale
localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
localedef -i de_DE -f ISO-8859-1 de_DE
localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
localedef -i de_DE -f UTF-8 de_DE.UTF-8
localedef -i en_GB -f UTF-8 en_GB.UTF-8
localedef -i en_HK -f ISO-8859-1 en_HK
localedef -i en_PH -f ISO-8859-1 en_PH
localedef -i en_US -f ISO-8859-1 en_US
localedef -i en_US -f UTF-8 en_US.UTF-8
localedef -i es_MX -f ISO-8859-1 es_MX
localedef -i fa_IR -f UTF-8 fa_IR
localedef -i fr_FR -f ISO-8859-1 fr_FR
localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
localedef -i it_IT -f ISO-8859-1 it_IT
localedef -i it_IT -f UTF-8 it_IT.UTF-8
localedef -i ja_JP -f EUC-JP ja_JP
localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
localedef -i zh_CN -f GB18030 zh_CN.GB18030

make localedata/install-locales

cat > /etc/nsswitch.conf << "EOF"
passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

EOF

wget -q http://www.iana.org//time-zones/repository/releases/tzdata2012j.tar.gz
tar -xf ../tzdata2012j.tar.gz

ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica\
          asia australasia backward pacificnew solar87 solar88 solar89\
          systemv; do
    zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
    zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

cp -v zone.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

cat > /etc/ld.so.conf << "EOF"
/usr/local/lib
/opt/lib

EOF

cat >> /etc/ld.so.conf << "EOF"
# adds an include directory
include /etc/ld.so.conf.d/*.conf

EOF
mkdir /etc/ld.so.conf.d

cd ..
rm -rf glibc-build
rm -rf glibc-$VERSION