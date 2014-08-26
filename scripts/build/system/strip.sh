set -e

/tools/bin/find /{,usr/}{bin,lib,sbin} -type f\
    -exec /tools/bin/strip --strip-debug '{}' ';'
