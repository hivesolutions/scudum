depends() {
    for package in $@; do
        FORCE=0 REMOVE=0 REFRESH=0 scu.install $package
    done
}

rget() {
    urls=()
    params=()
    for value in "$@"; do
        if [[ "$value" == "-"* ]]; then
            params+=("$value")
        else
            urls+=("$value")
        fi
    done
    for url in ${urls[*]}; do
        wget --content-disposition --tries=1 --timeout=20 $url ${params[*]} && return 0
    done
    return 1
}

rgeti() {
    urls=()
    params=()
    for value in "$@"; do
        if [[ "$value" == "-"* ]]; then
            params+=("$value")
        else
            urls+=("$value")
        fi
    done
    for url in "$@"; do
        wget --no-check-certificate --content-disposition --tries=1 --timeout=20 $url ${params[*]} && return 0
    done
    return 1
}
