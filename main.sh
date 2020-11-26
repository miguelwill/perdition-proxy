#!/bin/bash

CRT="/etc/perdition/perdition.crt.pem"
KEY="/etc/perdition/perdition.key.pem"

makegdbm /etc/perdition/popmap.gdbm.db < /etc/perdition/popmap

/etc/init.d/rsyslog start

rm -v /var/run/perdition.imap4/perdition.imap4.pid
rm -v /var/run/perdition.imaps/perdition.imaps.pid
rm -v /var/run/perdition.managesieve/perdition.managesieve.pid
rm -v /var/run/perdition.pop3/perdition.pop3.pid
rm -v /var/run/perdition.pop3s/perdition.pop3s.pid

/etc/init.d/perdition start

tail -f /var/log/syslog
