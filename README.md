# Perdition Proxy
 perdition imap/pop3 proxy over Debian Buster and multiserver

[![Docker Pulls](https://img.shields.io/docker/pulls/miguelwill/perdition-proxy.svg?style=plastic)](https://hub.docker.com/r/miguelwill/perdition-proxy/)

# Description
base installation of preconfigured perdition to function as a proxy for the following protocols
pop3 (tcp/110 , with and without tls)
pop3s (tcp/995)
imap (143 , with and without tls)
Imaps (Tcp/993)

# Configuration

the configuration allows authentication assisted by servers mapped in the "popmap" file, which is mapped in "popmap.gdbm.db" for reading from authentication processes

example file format "/etc/perdition/popmap" using gmail.com and other domains:
gmail.com:imap.gmail.com
mydomain.com:hosting1.mydomain.com
clientdomain.com:hosting2.mydomain.com

the /etc/perdition/popmap file can also be loaded using the kubernetes configuration file function and will be mapped at startup.

this configuration allows that if someone connects via "pop3s" to the server, it will send the user "user@gmail.com" in the same way to the login with the remote server "imap.gmail.com" to the pop3s port.

in the same way that if you connect to the "imaps" service, it will connect to the mail.gmail.com imaps service.

this allows you to use the protocols enabled with the destination servers (if a server does not allow the use of pop3 and only imap, it will give login error due to the rejection of the destination server), but you can try configuring the enabled protocol to log and pass the data from the final server to the client.

the configuration will not verify the certificate with the remote server, so it can be used for different internal servers behind a firewall.

In the branch "debian-mariadb" use mariadb database for map servers and users

parameters of connection to database are in file /etc/perdition.conf in the following line:
map_library_opt "db:3306:dbPerdition:tblPerdition:perdition:perdition:servername:user:port"

these parameters are also defined in docker-compose.yml file

# Add Stack with config
  * download files from https://github.com/miguelwill/perdition-proxy
  * edit popmap file adding domains and servers
  * run for deploy stack : docker stack deploy -c docker-compose.yml proxypopdb
  * waith for db initialization

# Kubernetes / Rancher
  * you can create a configuration map with the list of domains and servers, and mount via volume in the path "/config", making available the path /config/popmap
  * /main.sh will import the list into the database at pod startup 

# Volume

  * '/etc/perdition' - "configuration files and domain mapping, plus files with certificate and key"

# Variables

  * 'TZ' - "time zone"
  * MYSQL_ROOT_PASSWORD: perdition
  * MYSQL_DATABASE: dbPerdition
  * MYSQL_USER: perdition
  * MYSQL_PASSWORD: perdition

# Files
  * '/etc/perdition/perdition.crt.pem' - "file with certificate, you can leave the self-signed or upload a valid certificate"
  * '/etc/perdition/perdition.key.pem' - "key file corresponding to the previous certificate"
  * '/etc/perdition/popmap' - "mapping of final servers for domain access distribution"
