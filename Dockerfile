FROM debian:buster-slim

LABEL maintainer "miguelwill@gmail.com"

VOLUME /etc/perdition

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    rsyslog \
    perdition \
    ca-certificates && \
    apt-get clean

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    default-mysql-client perdition-mysql && \
    apt-get clean

#copy default configuration
COPY perdition/default-perdition /etc/default/perdition

#copy configuration files into volume
COPY perdition/* /etc/perdition/

#create new dhparam with new image
RUN openssl dhparam -out /etc/perdition/dhparam.pem 2048

#Expose ports for services
EXPOSE 110/tcp 143/tcp 993/tcp 995/tcp


WORKDIR /etc/perdition

COPY main.sh /


ENTRYPOINT ["/main.sh"]
CMD ["DEFAULT"]
