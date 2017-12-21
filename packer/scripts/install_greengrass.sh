#!/bin/sh

GGFILE="/tmp/greengrass-ubuntu-x86-64-1.3.0.tar.gz"

tar xzf $GGFILE -C /
rm -f $GGFILE
