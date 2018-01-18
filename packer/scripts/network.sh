#!/bin/sh

# Disable predicatable network interface naming
rm -f /lib/systemd/network/99-default.link
sed -i 's/ens33/eth0/' /etc/network/interfaces
sed -i 's/^\(iface eth0 inet6 auto\)/# \1/' /etc/network/interfaces
sed -i 's/GRUB_CMDLINE_LINUX="\(.*\)"/GRUB_CMDLINE_LINUX="\1 net.ifnames=0"/' /etc/default/grub
sudo update-grub
