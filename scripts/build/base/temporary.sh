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

echo "temporary: starting temporary tools build process..."

/tools/repo/scripts/build/system/tree.sh

rm -rf sources && mkdir sources
cd sources

# builds the temporary tools that are required by the final system
# and that could not be cross compiled before entering the chroot
/tools/repo/scripts/build/tools/gettext.sh
/tools/repo/scripts/build/tools/bison.sh
/tools/repo/scripts/build/tools/perl.sh
/tools/repo/scripts/build/tools/zlib.sh
/tools/repo/scripts/build/tools/mpdecimal.sh
/tools/repo/scripts/build/tools/python3.sh
/tools/repo/scripts/build/tools/texinfo.sh
/tools/repo/scripts/build/tools/util-linux.sh

cd .. && rm -rf sources

echo "temporary: finished temporary tools build process"
