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
        # removes the partial file left by the failed download so
        # that the next location is saved under the same name
        rm -f $(basename ${url%%\?*})
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
    for url in ${urls[*]}; do
        wget --no-check-certificate --content-disposition --tries=1 --timeout=20 $url ${params[*]} && return 0
        # removes the partial file left by the failed download so
        # that the next location is saved under the same name
        rm -f $(basename ${url%%\?*})
    done
    return 1
}
