#!/bin/bash
# -*- coding: utf-8 -*-

# sets the execution break on error so that if any
# of the commands fails the execution is broken
set -e

# changes the currently working directory to the build one
# taking into account the deployed repository
cd /tools/repo/scripts/build

# runs the building part of the system, this is considered
# to be the main stage of the process
system/tree.sh
