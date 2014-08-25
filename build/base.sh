# exports a series of environment variables that
# are going to be used through the build process
export SCUDUM=${SCUDUM-/scudum}
export SCUDUM_TARGET=$(uname -m)-scudum-linux-gnu

# exposes the various build specific values so that
# the initial value for the building is "tools based"
export LC_ALL=POSIX
export PATH=/tools/bin:/bin:/usr/bin
export PREFIX=/tools

# exports the unsafe configuration flag so that
# a root user may configure all the packages
export FORCE_UNSAFE_CONFIGURE=1

# allows compialtion using four threads at a given
# time, should perform faster on multi core based
# processors (required for fast compilation)
export MAKEFLAGS="-j 4"
