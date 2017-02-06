# Trnsorflow r0.12
# Ubuntu/Linux 64-bit Python 3.5

FROM ubuntu:16.04
MAINTAINER yewoo <intwis100@naver.com>

# locale for tokyo
RUN cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# enable apt multiverse repository
RUN apt-get update && \
    apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository multiverse

# Disable frontend
ENV DEBIAN_FRONTEND=noninteractive

# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget \
  linux-generic 


##############################################################################
# anaconda python
##############################################################################
RUN apt-get update && \
    apt-get install -y wget bzip2 ca-certificates libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/* 

RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    /bin/bash Anaconda3-4.2.0-Linux-x86_64.sh -b -p /opt/conda && \                                 
    rm Anaconda3-4.2.0-Linux-x86_64.sh



ENV PATH /opt/conda/bin:$PATH
RUN pip install --upgrade pip



##############################################################################
# tensorflow
##############################################################################

ENV TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.12.1-cp35-cp35m-linux_x86_64.whl
RUN pip install --upgrade -I setuptools
RUN pip install --upgrade $TF_BINARY_URL


##############################################################################
# posgresql 9.6
##############################################################################

RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*



ENV PG_APP_HOME="/etc/docker-postgresql"\
    PG_VERSION=9.6 \
    PG_USER=postgres \
    PG_HOME=/var/lib/postgresql \
    PG_RUNDIR=/run/postgresql \
    PG_LOGDIR=/var/log/postgresql \
    PG_CERTDIR=/etc/postgresql/certs 


ENV PG_BINDIR=/usr/lib/postgresql/${PG_VERSION}/bin \
    PG_DATADIR=${PG_HOME}/${PG_VERSION}/main

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y acl \
      postgresql-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} postgresql-server-dev-${PG_VERSION} \
 && ln -sf ${PG_DATADIR}/postgresql.conf /etc/postgresql/${PG_VERSION}/main/postgresql.conf \
 && ln -sf ${PG_DATADIR}/pg_hba.conf /etc/postgresql/${PG_VERSION}/main/pg_hba.conf \
 && ln -sf ${PG_DATADIR}/pg_ident.conf /etc/postgresql/${PG_VERSION}/main/pg_ident.conf \
 && rm -rf ${PG_HOME} \
 && rm -rf /var/lib/apt/lists/*

COPY runtime/ ${PG_APP_HOME}/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 5432/tcp
VOLUME ["${PG_HOME}", "${PG_RUNDIR}"]
WORKDIR ${PG_HOME}


#############################################################################
# GIT, VI                                                                   #
#############################################################################

RUN apt-get update && apt-get install -y git vim && rm -rf /var/lib/apt/lists/*

#############################################################################
# django                                                                   #
#############################################################################

RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /home/docker/code/requirements.txt
WORKDIR /home/docker/code
RUN pip install -r /home/docker/code/requirements.txt

EXPOSE 8000/tcp

#############################################################################
# ssh                                                                       #
#############################################################################


RUN apt-get update && apt-get install -y  openssh-server && rm -rf /var/lib/apt/lists/*

RUN sed -ri 's/^Port\s+.*/Port 2266/' /etc/ssh/sshd_config
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM\s+.*/UsePAM no/' /etc/ssh/sshd_config

EXPOSE 2266/tcp
RUN echo 'root:screencast' | chpasswd
#RUN service ssh start

#############################################################################
# x11                                                                       #
#############################################################################
RUN apt-get update && apt-get install -y  xauth && rm -rf /var/lib/apt/lists/*


#############################################################################
# pycharm                                                                   #
#############################################################################

RUN mkdir /home/dev
RUN cd /home/dev
WORKDIR /home/dev
RUN wget https://download.jetbrains.com/python/pycharm-community-2016.3.2.tar.gz

 
RUN tar -xvf pycharm-community-2016.3.2.tar.gz
RUN mv pycharm-community-2016.3.2 pyc

#############################################################################
# firefox                                                                   #
#############################################################################
RUN apt-get update && apt-get install -y libglu1 firefox && rm -rf /var/lib/apt/lists/*


#############################################################################
# git                                                                   #
#############################################################################
RUN cd /home/dev
WORKDIR /home/dev
RUN git clone https://github.com/TensorMSA/hoyai.git

RUN echo "export PYTHON_HOME=/opt/conda" >> ~/.bashrc
RUN echo "export PATH=${PYTHON_HOME}/bin:$PATH" >> ~/.bashrc


#############################################################################
# chrome                                                                    #
#############################################################################
RUN mkdir /home/Download
RUN cd /home/Download
WORKDIR /home/Download
#RUN apt-get update && apt-get install -y libgconf2-4 libnss3-1d libxss1 && rm -rf /var/lib/apt/lists/*
#RUN apt-get install -f
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i ./google-chrome*.deb; exit 0
RUN apt-get update
RUN apt-get install -f -y
RUN dpkg -i ./google-chrome*.deb;


#############################################################################
# naver nanum font                                                          #
#############################################################################
RUN apt-get update && apt-get install -y fonts-nanum && rm -rf /var/lib/apt/lists/*

RUN cd /home/dev/hoyai
WORKDIR /home/dev/hoyai



ENTRYPOINT ["/sbin/entrypoint.sh"]

