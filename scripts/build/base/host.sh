#!/bin/bash
# -*- coding: utf-8 -*-

# sets the execution break on error so that if any
# of the commands fails the execution is broken
set -e +h

# sources the current system's configuration, that should
# have been created upon the root initialization process
# during the output shell operation
source /config

# sources the base configuration files including the one
# referring to system dependent variables
source /tools/repo/scripts/build/base/config.sh
source /tools/repo/scripts/build/base/config.system.sh

unset VERSION

echo "host: starting host tools build process..."

rm -rf sources && mkdir sources
cd sources

# builds the extra tools that the host root of a cross build requires
# to cross compile the system in the target root (not part of the
# temporary tools of a native build)
/tools/repo/scripts/build/tools/pkg-config.sh
/tools/repo/scripts/build/tools/gperf.sh
/tools/repo/scripts/build/tools/flex.sh
/tools/repo/scripts/build/tools/bzip2.sh
/tools/repo/scripts/build/tools/cpio.sh

cd .. && rm -rf sources

echo "host: finished host tools build process"
