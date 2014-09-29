# exports a series of environment variables that
# are going to be used through the build process
export SCUDUM=${SCUDUM-/scudum}
export SCUDUM_TARGET=$(uname -m)-scudum-linux-gnu

# exports the generic target value for a pc based
# infra-structure may be used in final scudum build
export PC_TARGET=$(uname -m)-pc-linux-gnu

# exports the unsafe configuration flag so that
# a root user may configure all the packages
export FORCE_UNSAFE_CONFIGURE=1

# exports the flag that defines the level of parallelism
# for the compilation of the various elements, this vaçue
# should be enough to take advantage of the various cores,
# this flag should also be used carefully as it is know to
# create some problems in compilation of some packages
export MAKEFLAGS="-j 8"

# the test value that defines if the current build
# should be done with unit tests runnig (more time)
export TEST=

# name of the current distribution of sucudum, the default
# value should be generic as no custom deployment is done
export DISTRIB="generic"

# variable that defines the complete set of extra packages
# that are going to be installed when the extras script
# execution is triggered (may be changed by others)
export EXTRAS="sudo python rsync iptables cifs-utils ntfsprogs"

# verifies if there's a local configuration file if there's
# one runs it's source so that it may be used for other operations
if [ -e config ]; then
    DISTRIB=${PWD##*/}
    source config
fi
