#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-v1}
DATE=${DATE-$(date +%y%m%d%H%M)}

FULL_NAME="%NAME_%VERSION_%DATE.tar.gz"

set -e

source ../base/config.sh

tar -zcvf $FULL_NAME $SCUDUM/*
