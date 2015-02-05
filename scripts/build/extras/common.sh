export PREFIX=${PREFIX-/usr}
export MAKEFLAGS=${MAKEFLAGS--j $(nproc)}

depends() {
    for package in $@; do
        FORCE=0 REMOVE=0 REFRESH=0 scu.install $package
    done
}

rget() {
    result=1
    for url in "$@"; do
        wget $url && return 0
    done
    echo "saiu ali2 $result"
    return $result
}
