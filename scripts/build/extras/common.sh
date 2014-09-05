PREFIX=${PREFIX-/usr}

depends() {
    for package in $@; do
        REMOVE=0 REFRESH=0 scu.install $package
    done
}
