#!/bin/sh

GGFILE="/tmp/greengrass-linux-x86-64-1.9.1.tar.gz"

tar xzf $GGFILE -C /
rm -f $GGFILE
