# exposes the various build specific values so that
# the initial value for the building is "tools based"
export LC_ALL=POSIX
export PATH=/cross/bin:/tools/bin:$PATH
export PREFIX=/tools
export PREFIX_CROSS=/cross

print_scudum_tools() {
    echo "LC_ALL := $LC_ALL"
    echo "PATH := $PATH"
    echo "PREFIX := $PREFIX"
}
