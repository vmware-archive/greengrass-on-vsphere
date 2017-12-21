#!/bin/sh

apt-get update
apt-get install -y  open-vm-tools
apt-get install -y  sqlite3 git
apt-get install -y  bc

sudo useradd -r ggc_user
sudo groupadd -r ggc_group
