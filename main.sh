#!/bin/bash


echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

CRT="/etc/perdition/perdition.crt.pem"
KEY="/etc/perdition/perdition.key.pem"

makegdbm /etc/perdition/popmap.gdbm.db < /etc/perdition/popmap

/etc/init.d/rsyslog start

/etc/init.d/perdition start

#/usr/sbin/perdition -d -f /etc/perdition/perdition.conf


tail -f /var/log/syslog
