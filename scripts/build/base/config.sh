# exports a series of environment variables that
# are going to be used through the build process
export SCUDUM=${SCUDUM-/scudum}
export SCUDUM_TARGET=$(uname -m)-scudum-linux-gnu

# exports the unsafe configuration flag so that
# a root user may configure all the packages
export FORCE_UNSAFE_CONFIGURE=1

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
