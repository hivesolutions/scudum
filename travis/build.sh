#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

BASE=$DIR/..
PATH=$PATH:$BASE/scudum/scripts

scudum deploy
