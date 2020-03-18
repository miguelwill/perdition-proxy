#!/bin/bash


echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

CRT="/etc/perdition/perdition.crt.pem"
KEY="/etc/perdition/perdition.key.pem"
DB=$MYSQL_DATABASE
USER=$MYSQL_USER
PASS=$MYSQL_PASSWORD
HOST=${MYSQL_HOST:-"db"}


while ! mysqladmin ping -h"$HOST" --silent; do
    echo "waiting for mariadb service port....";
    sleep 1
done
#makegdbm /etc/perdition/popmap.gdbm.db < /etc/perdition/popmap

#DB initialization

TBL=$(echo "show tables;" | mysql -h$HOST -u$USER -p$PASS $DB|wc -l)

if [ "$TBL" -gt "0" ]
then
        echo "truncate exist data...";
        echo "truncate tblPerdition;" | mysql -h$HOST -u$USER -p$PASS $DB;
else
        echo "table not exist, initializing...";
        SQL="CREATE TABLE tblPerdition (user varchar(128) NOT NULL, servername varchar(255) NOT NULL, port varchar(8) DEFAULT NULL, PRIMARY KEY (user), KEY idxtblPerdition_user (user) ) ENGINE=MyISAM DEFAULT CHARSET=latin1;"
        echo $SQL | mysql -h$HOST -u$USER -p$PASS $DB;
fi

#import server list from popmap file to table in DB
if [ -f /config/popmap ]
then
	cp -f /config/popmap /etc/perdition/popmap
fi



for i in $(cat /etc/perdition/popmap);
do
        DOMAIN=$(echo $i|cut -d: -f1);
        SERVER=$(echo $i|cut -d: -f2);
        PORT=$(echo $i|cut -d: -f3);
        INSERT="INSERT INTO tblPerdition (user, servername, port) VALUES ('$DOMAIN', '$SERVER', '$PORT');"
        echo $INSERT | mysql -h$HOST -u$USER -p$PASS $DB;
done

/etc/init.d/rsyslog start

mkdir -m600  /run/sshd
/etc/init.d/ssh start

/etc/init.d/perdition start

#/usr/sbin/perdition -d -f /etc/perdition/perdition.conf


tail -f /var/log/syslog
