#!/bin/bash
# -*- coding: utf-8 -*-

# sets the execution break on error so that if any
# of the commands fails the execution is broken
set -e

# runs the building part of the system, this is considered
# to be the main stage of the process
../system/tree.sh
