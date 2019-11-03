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
#generate dhparam

# Create and configure the VNC user
#ARG VNCPASS
#ENV VNCPASS ${VNCPASS:-secret}
ENV 	TZ=America/Santiago 

#RUN useradd remote --create-home --shell /bin/bash --user-group --groups adm,sudo && \
#    echo "remote:$VNCPASS" | chpasswd

RUN echo "root:Root" | chpasswd

#copy default configuration
COPY perdition/default-perdition /etc/default/perdition

#copy configuration files into volume
COPY perdition/* /etc/perdition/

EXPOSE 22/tcp 110/tcp 143/tcp 993/tcp 995/tcp
#EXPOSE 5900

WORKDIR /etc/perdition

COPY main.sh /


ENTRYPOINT ["/main.sh"]
CMD ["DEFAULT"]

