#!/bin/bash
# -*- coding: utf-8 -*-

set -e +h

case "$2" in
    PBTN) halt -p ;;
    *) logger "ACPI action undefined: $2" ;;
esac
