#!/bin/sh

# Unload previous driver
KVER=`uname -r`
if [ `grep -e '^pt3_drv' /proc/modules | wc -l` -ne 0 ]; then
    modprobe -r pt3_drv
fi

install -D -v -m 644 ./etc/99-pt3.rules /etc/udev/rules.d/99-pt3.rules
install -D -v -m 644 ./etc/blacklist-dvb-pt3.conf /etc/modprobe.d/blacklist-dvb-pt3.conf
