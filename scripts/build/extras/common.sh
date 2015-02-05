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
        wget $url || result=$? || true
        echo "sacou com $result"
        if [ "$result" == "0" ]; then
            echo "saiu aki1 $result"
            return $result
        fi
    done
    echo "saiu ali2 $result"
    return $result
}
