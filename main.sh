#!/bin/bash

CRT="/etc/perdition/perdition.crt.pem"
KEY="/etc/perdition/perdition.key.pem"

makegdbm /etc/perdition/popmap.gdbm.db < /etc/perdition/popmap

/etc/init.d/rsyslog start

/etc/init.d/perdition restart

tail -f /var/log/syslog
