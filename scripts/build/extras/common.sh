export PREFIX=${PREFIX-/usr}
export MAKEFLAGS=${MAKEFLAGS--j $(nproc)}

depends() {
    for package in $@; do
        FORCE=0 REMOVE=0 REFRESH=0 scu.install $package
    done
}
