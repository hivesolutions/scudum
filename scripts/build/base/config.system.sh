export PERL5LIB="/tools/lib/perl5:/tools/lib/perl5/site_perl"

if [ "$SCUDUM_CROSS" == "1" ]; then
    case "$SCUDUM_ARCH" in
        arm)
            export CC="$ARCH_TARGET-gcc"
            export CXX="$ARCH_TARGET-g++"
            export AR="$ARCH_TARGET-ar"
            export RANLIB="$ARCH_TARGET-ranlib"
            export LD="$ARCH_TARGET-ld"
            export LD_LIBRARY_PATH="/usr/lib:/lib"
            export PKG_CONFIG_PATH="/usr/lib/pkgconfig:/lib/pkgconfig"
            export CFLAGS="-I/usr/include -I/include -D__ARM_PCS_VFP -Wl,-rpath,/usr/lib -Wl,-rpath,/lib"
            export CXXFLAGS="-I/usr/include -I/include -D__ARM_PCS_VFP -Wl,-rpath,/usr/lib -Wl,-rpath,/lib"
            export LDFLAGS="-L/usr/lib -L/lib"
            ;;
    esac
fi
