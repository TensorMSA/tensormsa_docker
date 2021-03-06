# Trnsorflow r0.12
# Ubuntu/Linux 64-bit Python 3.5
#FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

#FROM nvidia/cuda:8.0-cudnn6-runtime-ubuntu16.04
MAINTAINER yewoo <intwis100@naver.com>




#set locale ko_KR

RUN apt-get clean && apt-get update && apt-get install -y locales

RUN locale-gen ko_KR.UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
# Pick up some TF dependencies
ENV DEBIAN_FRONTEND=noninteractive

# Install wget and build-essential
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common build-essential linux-generic && \
  rm -rf /var/lib/apt/lists/*


RUN apt-get update \
     && apt-get install -y firefox-locale-ko fcitx-hangul  language-pack-ko language-pack-gnome-ko language-pack-ko-base language-pack-gnome-ko-base \
     && apt-get autoclean \
     && apt-get autoremove \
     && rm -rf /var/lib/apt/lists/*
  

##############################################################################
# anaconda python
##############################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends bzip2 ca-certificates libmysqlclient-dev wget && \
    rm -rf /var/lib/apt/lists/* 

RUN wget --no-check-certificate https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh && \
/bin/bash Anaconda3-4.4.0-Linux-x86_64.sh -b -p /opt/conda && \
rm Anaconda3-4.4.0-Linux-x86_64.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda install python=3.6
RUN pip install --upgrade pip

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

RUN wget --quiet --no-check-certificate -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y acl \
      postgresql-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} postgresql-server-dev-${PG_VERSION} \
 && ln -sf ${PG_DATADIR}/postgresql.conf /etc/postgresql/${PG_VERSION}/main/postgresql.conf \
 && ln -sf ${PG_DATADIR}/pg_hba.conf /etc/postgresql/${PG_VERSION}/main/pg_hba.conf \
 && ln -sf ${PG_DATADIR}/pg_ident.conf /etc/postgresql/${PG_VERSION}/main/pg_ident.conf \
 && rm -rf ${PG_HOME} \
 && rm -rf /var/lib/apt/lists/*

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
WORKDIR /home/docker/code
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
RUN wget --no-check-certificate https://download.jetbrains.com/python/pycharm-community-2017.1.2.tar.gz

RUN tar -xvf pycharm-community-2017.1.2.tar.gz
RUN mv pycharm-community-2017.1.2 pyc
RUN ln -s /home/dev/pyc/bin/pycharm.sh /usr/bin/pycharm
RUN rm -f pycharm-community-2017.1.2.tar.gz

#############################################################################
# git                                                                   #
#############################################################################
RUN cd /home/dev
WORKDIR /home/dev
RUN git clone https://github.com/TensorMSA/tensormsa.git 
RUN echo "export PYTHON_HOME=/opt/conda" >> ~/.bashrc
RUN echo "export PATH=${PYTHON_HOME}/bin:$PATH" >> ~/.bashrc

#############################################################################
# chrome                                                                    #
#############################################################################
RUN apt-get update && apt-get install -y chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg && rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/chromium-browser /usr/bin/google-chrome
RUN echo "CHROMIUM_FLAGS='--no-sandbox --start-maximized --user-data-dir'" > ~/.chromium-browser.init

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
RUN cd /home/dev/tensormsa
WORKDIR /home/dev/tensormsa

#############################################################################
# vnc server                                                       #
#############################################################################
ENV DISPLAY :1
ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1280x1024
ENV VNC_PW vncpassword
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends supervisor vim vnc4server xfce4 ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && rm -rf /var/lib/apt/lists/*

EXPOSE 5901
ADD .vnc /root/.vnc
ADD .config /root/.config
ADD scripts /root/scripts
RUN chmod +x /root/.vnc/xstartup /etc/X11/xinit/xinitrc /root/scripts/*.sh 

#############################################################################
# raabbitmq-server                                                 #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends rabbitmq-server && rm -rf /var/lib/apt/
EXPOSE 5672

###############################################################################
# hdfview                                                            #
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
        python3-dev \
        python3-pip \
        rsync \
        software-properties-common \
        unzip \
        zip \
        zlib1g-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



RUN pip install --trusted-host pypi.python.org \
 https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp36-cp36m-linux_x86_64.whl
# Clean up pip wheel and Bazel cache when done.
# TensorBoard
EXPOSE 6006

#############################################################################
# nlp setting                                                               #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends openjdk-8-jdk && rm -rf /var/lib/apt/lists/*

RUN conda config --set ssl_verify false
RUN conda install -y -c  conda-forge jpype1
RUN conda install -y  mkl

RUN mkdir /home/dev/mecab
RUN cd /home/dev/mecab
WORKDIR /home/dev/mecab

RUN curl -fSsL -O https://raw.githubusercontent.com/konlpy/konlpy/master/scripts/mecab.sh
RUN chmod +x mecab.sh
RUN ./mecab.sh

RUN conda install -y libgcc

RUN wget --no-check-certificate https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.0.1-20150920.tar.gz \
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
# neo4j                                                               #
#############################################################################
RUN cd /home/dev
WORKDIR /home/dev

RUN wget http://dist.neo4j.org/neo4j-community-3.1.3-unix.tar.gz
RUN tar -xf neo4j-community-3.1.3-unix.tar.gz
#RUN mv neo4j-community-3.1.2 neo4j
RUN rm -f neo4j-community-3.1.3-unix.tar.gz 
EXPOSE 7474 7678 5555

#############################################################################
# nginx uwsgi setting                      #
#############################################################################
COPY uwsgi /home/dev/uwsgi
COPY nginx/nginx.conf /etc/nginx/nginx.conf

#############################################################################
# Memcached                                #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends memcached python-memcache && rm -rf /var/lib/apt/lists/*

############################################################################
# pip & entrypoint setting                                #
#############################################################################
RUN apt-get clean
COPY requirements.txt /home/docker/code/requirements.txt
WORKDIR /home/docker/code
RUN pip install -r /home/docker/code/requirements.txt

#############################################################################
# uwsgi instll 
##########################################################################
RUN conda install -c conda-forge uwsgi

RUN rm -rf /tmp/pip && \
    rm -rf /root/.cache


############################################################################
# make data src path sharing                              #
#############################################################################
RUN mkdir /hoya_src_root
RUN mkdir /hoya_str_root
RUN mkdir /hoya_model_root
RUN mkdir /home/dev/hoyai_jupyter
RUN mkdir /home/dev/hoyai_playground

###########################################################
#                         XGBOOST                         #
###########################################################
RUN apt-get update && apt-get install -y --no-install-recommends cmake python-setuptools && rm -rf /var/lib/apt/lists/*

RUN cd /home/dev
WORKDIR /home/dev
RUN git clone --recursive https://github.com/dmlc/xgboost; exit 0

RUN cd xgboost; make -j4
RUN cd /home/dev/xgboost/python-package
WORKDIR /home/dev/xgboost/python-package
RUN python setup.py install
RUN echo "export PYTHONPATH=/home/dev/xgboost/python-package" >> ~/.bashrc

###########################################################
#                         lightGBM                        #
###########################################################
RUN apt-get update && apt-get install -y --no-install-recommends cmake python-setuptools && rm -rf /var/lib/apt/lists/*
RUN cd /home/dev
WORKDIR /home/dev
RUN git clone --recursive https://github.com/Microsoft/LightGBM ; cd LightGBM
RUN mkdir build ; cd build
WORKDIR /home/dev/LightGBM/build
RUN cmake ..
RUN make -j4

#############################################################################
# node.js npm  redmine                                    #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get update && apt-get install -y --no-install-recommends nodejs && rm -rf /var/lib/apt/lists/*
RUN  add-apt-repository ppa:webupd8team/sublime-text-3
RUN apt-get update && apt-get install -y --no-install-recommends sublime-text-installer && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends graphviz && rm -rf /var/lib/apt/lists/*


#############################################################################
# dlib                                        #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends cmake libboost-all-dev && rm -rf /var/lib/apt/lists/*
COPY runtime/ ${PG_APP_HOME}/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

################################################################################
#NPM INSTALL NPM BUILD
################################################################################
RUN npm install --prefix /home/dev/tensormsa/gui/static
#RUN npm run build --prefix /home/dev/tensormsa/gui/static

################################################################################
#opencv compile 
################################################################################
RUN apt-get update && \
        apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        libavformat-dev \
        libpq-dev \
        libopencv-dev \
        libtiff5-dev libjpeg-dev libjasper-dev \
        libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev \
        libtbb-dev \
        libgtk2.0-dev \
        libqt4-dev
RUN pip install numpy
RUN add-apt-repository ppa:jonathonf/ffmpeg-3 && \
    add-apt-repository ppa:jonathonf/tesseract && \
    apt-get update 
RUN apt install -y ffmpeg libav-tools x264 x265
WORKDIR /
ENV OPENCV_VERSION="3.2.0"
RUN wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \ 
&& rm ${OPENCV_VERSION}.zip

RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DWITH_FFMPEG=ON \
  -DWITH_CUDA=OFF \
  -DWITH_QT=ON \
  -DENABLE_AVX=ON \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-${OPENCV_VERSION}/modules \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.6) \
  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
&& make -j4 install

RUN cp /opencv-3.2.0/cmake_binary/lib/python3/cv2.cpython-36m-x86_64-linux-gnu.so /opt/conda/lib/python3.6/site-packages/cv2/
RUN dbus-uuidgen > /etc/machine-id
 
#RUN cd ~ 
ENTRYPOINT ["/sbin/entrypoint.sh"]
