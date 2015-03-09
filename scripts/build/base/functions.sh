depends() {
    for package in $@; do
        FORCE=0 REMOVE=0 REFRESH=0 scu.install $package
    done
}

rget() {
    for url in "$@"; do
        wget --tries=1 --timeout=20 $url && return 0
    done
    return 1
}

rgeti() {
    for url in "$@"; do
        wget --no-check-certificate --tries=1 --timeout=20 $url && return 0 || true
    done
    return 1
}
