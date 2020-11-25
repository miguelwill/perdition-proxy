FROM debian:buster-slim

LABEL maintainer "miguelwill@gmail.com"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openssl \
    rsyslog \
    perdition \
    procps \
    ca-certificates && \
    apt-get clean

#create new dhparam with new image
RUN openssl dhparam -out /etc/perdition/dhparam.pem 2048

#copy default configuration
COPY perdition/default-perdition /etc/default/perdition

#copy configuration files into configuration folder
COPY perdition/* /etc/perdition/

#Expose ports for services
EXPOSE 110/tcp 143/tcp 993/tcp 995/tcp

WORKDIR /etc/perdition

COPY main.sh /


ENTRYPOINT ["/main.sh"]
CMD ["DEFAULT"]
