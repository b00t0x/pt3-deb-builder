#!/bin/sh

# Unload previous driver
KVER=`uname -r`
if [ `grep -e '^pt3_drv' /proc/modules | wc -l` -ne 0 ]; then
    modprobe -r pt3_drv
fi

if [ `find /lib/modules/ -name pt3_drv.ko | wc -l` -eq 0 ]; then
    rm -fv /etc/udev/rules.d/99-pt3.rules /etc/modprobe.d/blacklist-dvb-pt3.conf
fi
