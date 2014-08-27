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
