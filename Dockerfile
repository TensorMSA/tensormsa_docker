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
RUN apt-get update && apt-get install -y --no-install-recommends build-essential wget  linux-generic && \
  rm -rf /var/lib/apt/lists/*
  

##############################################################################
# anaconda python
##############################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends bzip2 ca-certificates libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/* 

RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    /bin/bash Anaconda3-4.2.0-Linux-x86_64.sh -b -p /opt/conda && \                                 
    rm Anaconda3-4.2.0-Linux-x86_64.sh



ENV PATH /opt/conda/bin:$PATH
RUN pip install --upgrade pip


 
##############################################################################
# tensorflow
##############################################################################
#ENV TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.0-cp35-cp35m-linux_x86_64.whl
#ENV TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.12.1-cp35-cp35m-linux_x86_64.whl
#RUN pip install --upgrade -I setuptools
#RUN pip install --upgrade $TF_BINARY_URL


##############################################################################
# posgresql 9.6
##############################################################################

RUN apt-get update && apt-get install -y --no-install-recommends sudo && rm -rf /var/lib/apt/lists/*



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

#COPY runtime/ ${PG_APP_HOME}/
#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 5432/tcp
VOLUME ["${PG_HOME}", "${PG_RUNDIR}"]
WORKDIR ${PG_HOME}


#############################################################################
# GIT, VI                                                                   #
#############################################################################

RUN apt-get update && apt-get install -y --no-install-recommends git vim && rm -rf /var/lib/apt/lists/*

#############################################################################
# django                                                                   #
#############################################################################

RUN apt-get update && apt-get install -y --no-install-recommends nginx && rm -rf /var/lib/apt/lists/*

#COPY requirements.txt /home/docker/code/requirements.txt
WORKDIR /home/docker/code
#RUN pip install -r /home/docker/code/requirements.txt

EXPOSE 8000/tcp

#############################################################################
# ssh                                                                       #
#############################################################################


RUN apt-get update && apt-get install -y --no-install-recommends openssh-server && rm -rf /var/lib/apt/lists/*

RUN sed -ri 's/^Port\s+.*/Port 2266/' /etc/ssh/sshd_config
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM\s+.*/UsePAM no/' /etc/ssh/sshd_config

EXPOSE 2266/tcp
RUN echo 'root:screencast' | chpasswd
#RUN service ssh start

#############################################################################
# x11                                                                       #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends xauth && rm -rf /var/lib/apt/lists/*


#############################################################################
# pycharm                                                                   #
#############################################################################

RUN mkdir /home/dev
RUN cd /home/dev
WORKDIR /home/dev
RUN wget https://download.jetbrains.com/python/pycharm-community-2016.3.2.tar.gz

 
RUN tar -xvf pycharm-community-2016.3.2.tar.gz
RUN mv pycharm-community-2016.3.2 pyc
RUN ln -s /home/dev/pyc/bin/pycharm.sh /usr/bin/pycharm
RUN rm -f pycharm-community-2016.3.2.tar.gz
#############################################################################
# firefox                                                                   #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends libglu1 firefox && rm -rf /var/lib/apt/lists/*


#############################################################################
# git                                                                   #
#############################################################################
RUN cd /home/dev
WORKDIR /home/dev
RUN git clone https://github.com/TensorMSA/hoyai.git

RUN echo "export PYTHON_HOME=/opt/conda" >> ~/.bashrc
RUN echo "export PATH=${PYTHON_HOME}/bin:$PATH" >> ~/.bashrc
#RUN echo "export HOSTNAME=`hostname`" >> ~/.bashrc

#############################################################################
# chrome                                                                    #
#############################################################################
#RUN mkdir /home/Download
#RUN cd /home/Download
#WORKDIR /home/Download
#RUN apt-get update && apt-get install -y libgconf2-4 libnss3-1d libxss1 && rm -rf /var/lib/apt/lists/*
#RUN apt-get install -f
#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#RUN dpkg -i ./google-chrome*.deb; exit 0
#RUN apt-get update
#RUN apt-get install -f -y
#RUN dpkg -i ./google-chrome*.deb;
RUN apt-get update \
    && apt-get install -y --no-install-recommends chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg \
    && rm -rf /var/lib/apt/ \
    && ln -s /usr/bin/chromium-browser /usr/bin/google-chrome \
    # fix to start chromium in a Docker container
    && echo "CHROMIUM_FLAGS='--no-sandbox --start-maximized --user-data-dir'" > ~/.chromium-browser.init


#############################################################################
# naver nanum font                                                          #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends fonts-nanum && rm -rf /var/lib/apt/lists/*

#############################################################################
# pgadmin3                                                          #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends aptitude
RUN aptitude install -y pgadmin3
RUN apt-get install -y --no-install-recommends pgadmin3=1.22.0-1 pgadmin3-data=1.22.0-1&& rm -rf /var/lib/apt/lists/*

#############################################################################
# korean pack                                                       #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends language-pack-ko
RUN apt-get install -y --no-install-recommends language-pack-ko-base&& rm -rf /var/lib/apt/lists/*

RUN echo "LANG=\"ko_KR.UTF-8\"" >> ~/.bashrc


RUN cd /home/dev/hoyai
WORKDIR /home/dev/hoyai


#############################################################################
# vnc server                                                       #
#############################################################################
ENV DISPLAY :1
ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1280x1024
ENV VNC_PW vncpassword

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends supervisor vim vnc4server xfce4 ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && rm -rf /var/lib/apt/


EXPOSE 5901

ADD .vnc /root/.vnc
ADD .config /root/.config
ADD scripts /root/scripts
RUN chmod +x /root/.vnc/xstartup /etc/X11/xinit/xinitrc /root/scripts/*.sh 
#RUN /root/scripts/bash_auto_completion.sh 

#############################################################################
# raabbitmq-server                                                 #
#############################################################################

RUN apt-get update && apt-get install -y --no-install-recommends rabbitmq-server && rm -rf /var/lib/apt/
EXPOSE 5672

###########UN apt-get update && apt-get install -y --no-install-recommends nodejs && rm -rf /var/lib/apt/lists/*

# hdfview    gnome-terminal                                             #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends hdfview && rm -rf /var/lib/apt/lists/*

#############################################################################
# node.js npm                                             #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends curl 
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get update && apt-get install -y --no-install-recommends nodejs && rm -rf /var/lib/apt/lists/*

##############################################################################
# tensorflow
##############################################################################

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        libcurl3-dev \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        zip \
        zlib1g-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up Bazel.

# We need to add a custom PPA to pick up JDK8, since trusty doesn't
# have an openjdk8 backport.  openjdk-r is maintained by a reliable contributor:
# Matthias Klose (https://launchpad.net/~doko).  It will do until
# we either update the base image beyond 14.04 or openjdk-8 is
# finally backported to trusty; see e.g.
#   https://bugs.launchpad.net/trusty-backports/+bug/1368094
RUN add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends openjdk-8-jdk openjdk-8-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Running bazel inside a `docker build` command causes trouble, cf:
#   https://github.com/bazelbuild/bazel/issues/134
# The easiest solution is to set up a bazelrc file forcing --batch.
RUN echo "startup --batch" >>/etc/bazel.bazelrc
# Similarly, we need to workaround sandboxing issues:
#   https://github.com/bazelbuild/bazel/issues/418
RUN echo "build --spawn_strategy=standalone --genrule_strategy=standalone" \
    >>/etc/bazel.bazelrc
# Install the most recent bazel release.
ENV BAZEL_VERSION 0.4.5
WORKDIR /
RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE.txt && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

# Download and build TensorFlow.
RUN cd /home/dev/
WORKDIR /home/dev
RUN git clone https://github.com/tensorflow/tensorflow.git && \
    cd tensorflow && \
    git checkout r1.1
WORKDIR /home/dev/tensorflow

# TODO(craigcitro): Don't install the pip package, since it makes it
# more difficult to experiment with local changes. Instead, just add
# the built directory to the path.

ENV CI_BUILD_PYTHON python

RUN tensorflow/tools/ci_build/builds/configured CPU \
    bazel build -c opt tensorflow/tools/pip_package:build_pip_package 

RUN bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/pip 



#RUN curl -fSsL -O https://bootstrap.pypa.io/get-pip.py && \
#    python get-pip.py && \
#    rm get-pip.py

RUN pip install /tmp/pip/tensorflow-*.whl 
RUN rm -rf /tmp/pip && \
    rm -rf /root/.cache

# Clean up pip wheel and Bazel cache when done.

# TensorBoard
EXPOSE 6006
#############################################################################
# Memcached                                #
#############################################################################

RUN apt-get update && apt-get install -y --no-install-recommends memcached && rm -rf /var/lib/apt/lists/*

#############################################################################
# nlp setting                                                               #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends openjdk-8-jdk && rm -rf /var/lib/apt/lists/*


RUN conda install -y -c  conda-forge jpype1
RUN conda install -y  mkl

RUN mkdir /home/dev/mecab
RUN cd /home/dev/mecab
WORKDIR /home/dev/mecab

RUN curl -O https://raw.githubusercontent.com/konlpy/konlpy/master/scripts/mecab.sh
RUN chmod +x mecab.sh
RUN ./mecab.sh

RUN conda install -y libgcc

RUN wget https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.0.1-20150920.tar.gz \
&& tar xzvf mecab-ko-dic-2.0.1-20150920.tar.gz \
&& cd mecab-ko-dic-2.0.1-20150920 \
&& sudo ldconfig \
&& ldconfig -p | grep /usr/local/lib \
&& ./clean \
&& ./configure \
&& make \
&& make install

RUN rm -f  mecab-ko-dic-2.0.1-20150920.tar.gz
RUN rm -f /tmp/mecab-*.tar.gz
RUN rm -Rf /tmp/mecab*-20150920
 

#############################################################################
# pip & entrypoint setting                                #
#############################################################################
RUN apt-get clean

COPY requirements.txt /home/docker/code/requirements.txt
WORKDIR /home/docker/code
RUN pip install -r /home/docker/code/requirements.txt


RUN rm -rf /tmp/pip && \
    rm -rf /root/.cache




COPY runtime/ ${PG_APP_HOME}/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

#ENV HOSTNAME hostname


ENTRYPOINT ["/sbin/entrypoint.sh"]

