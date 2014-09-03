PREFIX=${PREFIX-/usr}

depends() {
    for package in $@; do
        REFRESH=0 . extras.install $package
    done
}
