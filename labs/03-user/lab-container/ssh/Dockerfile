FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y wget
RUN apt-get install -y curl

RUN apt-get install -y iproute2
RUN apt-get install -y netcat-openbsd
RUN apt-get install -y iputils-ping
RUN apt-get install -y bash-completion
RUN apt-get install -y iptables
RUN apt-get install -y ifupdown
RUN apt-get install -y net-tools

RUN apt-get install -y firefox
RUN apt-get install -y qbittorrent

RUN apt-get install -y openssh-server

RUN useradd -s /bin/bash -m -d /home/student student
RUN echo "root\nroot" | passwd root

RUN echo "student\nstudent" | passwd student
RUN echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
RUN echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN su -c "xauth" student

RUN service ssh start

RUN apt-get -y clean

RUN rm -rf /var/lib/apt/lists/*

COPY ./run.sh /usr/local/bin/run.sh
CMD ["run.sh"]

USER root
WORKDIR /root
