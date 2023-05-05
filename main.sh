#!/bin/bash

CRT="/etc/perdition/perdition.crt.pem"
KEY="/etc/perdition/perdition.key.pem"

if [ ! -f "$CRT" ] || [ ! -f "$KEY" ]; then
    echo "certificado y key no definido, generando nuevo"
    # Generar certificado autofirmado y key
    openssl req -new -x509 -days 365 -nodes -out $CRT -keyout $KEY -subj "/C=CL/ST=MT/L=Santiago/O=My Organization/OU=TI/CN=perdition-proxy.org"
fi


makegdbm /etc/perdition/popmap.gdbm.db < /etc/perdition/popmap

/etc/init.d/rsyslog start

rm -v /var/run/perdition.imap4/perdition.imap4.pid
rm -v /var/run/perdition.imaps/perdition.imaps.pid
rm -v /var/run/perdition.managesieve/perdition.managesieve.pid
rm -v /var/run/perdition.pop3/perdition.pop3.pid
rm -v /var/run/perdition.pop3s/perdition.pop3s.pid

/etc/init.d/perdition start  &

touch /var/log/syslog
tail -f /var/log/syslog
