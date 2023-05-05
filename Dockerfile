FROM ubuntu:jammy

LABEL maintainer "miguelwill@gmail.com"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openssl \
    rsyslog \
    perdition \
    netbase \
    procps \
    ca-certificates && \
    apt-get clean

#copy default configuration
COPY perdition/default-perdition /etc/default/perdition

#copy configuration files into configuration folder
COPY perdition/* /etc/perdition/
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

#create new dhparam with new image
RUN openssl rand -writerand /root/.rnd && \
    openssl dhparam -out /etc/perdition/dhparam.pem 2048

#Expose ports for services
EXPOSE 110/tcp 143/tcp 993/tcp 995/tcp

WORKDIR /etc/perdition

COPY main.sh /


ENTRYPOINT ["/main.sh"]
CMD ["DEFAULT"]
