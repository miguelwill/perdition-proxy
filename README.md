# Perdition Proxy
 perdition imap/pop3 proxy over Debian Buster and multiserver

[![Docker Pulls](https://img.shields.io/docker/pulls/miguelwill/perdition-proxy.svg?style=plastic)](https://hub.docker.com/r/miguelwill/perdition-proxy/)

# Description
base installation of preconfigured perdition to function as a proxy for the following protocols
pop3 (tcp/110 , with and without tls)
pop3s (tcp/995)
imap (143 , with and without tls)
Imaps (Tcp/993)

#Configuration

the configuration allows authentication assisted by servers mapped in the "popmap" file, which is mapped in "popmap.gdbm.db" for reading from authentication processes

example file format "/etc/perdition/popmap" using gmail.com and other domains:
gmail.com:imap.gmail.com
mydomain.com:hosting1.mydomain.com
clientdomain.com:hosting2.mydomain.com

the /etc/perdition/popmap file can also be loaded using the kubernet configuration function and will be mapped at startup.

this configuration allows that if someone connects via "pop3s" to the server, it will send the user "usuario@gmail.com" in the same way to the login with the remote server "imap.gmail.com" to the pop3s port.

in the same way that if you connect to the "imaps" service, it will connect to the mail.gmail.com imaps service.

this allows you to use the protocols enabled with the destination servers (if a server does not allow the use of pop3 and only imap, it will give login error due to the rejection of the destination server), but you can try configuring the enabled protocol to log and pass the data from the final server to the client.

the configuration will not verify the certificate with the remote server, so it can be used for different internal servers behind a firewall.

#Volume

  * /etc/perdition 

#Variables

  * 'TZ' - "time zone" *
