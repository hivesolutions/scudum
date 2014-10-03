export PREFIX=${PREFIX-/usr}
export MAKEFLAGS=${MAKEFLAGS--j $(nproc)}

depends() {
    for package in $@; do
        REMOVE=0 REFRESH=0 FORCE=0 scu.install $package
    done
}
