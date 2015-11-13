#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

export BASE=$DIR/..
export PATH=$PATH:$BASE/scripts

sudo scudum install
