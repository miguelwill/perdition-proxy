FROM debian:buster

LABEL maintainer "miguelwill@gmail.com"

VOLUME /etc/perdition

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openssh-server \
    curl \
    wget \
    net-tools vim rsyslog \
    perdition ca-certificates \
    rsync && \
    apt-get clean

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    default-mysql-client perdition-mysql && \
    apt-get clean


ENV 	TZ=America/Santiago 

# Set password for root for ssh access
RUN echo "root:Root" | chpasswd

#copy default configuration
COPY perdition/default-perdition /etc/default/perdition

#copy configuration files into volume
COPY perdition/* /etc/perdition/

#Expose ports for services
EXPOSE 22/tcp 110/tcp 143/tcp 993/tcp 995/tcp


WORKDIR /etc/perdition

COPY main.sh /


ENTRYPOINT ["/main.sh"]
CMD ["DEFAULT"]

