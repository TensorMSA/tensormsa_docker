FROM ubuntu:16.04

MAINTAINER Craig Citro <craigcitro@google.com>
# set locale ko_KR
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



#############################################################################
# vnc server                                                                 #
#############################################################################
ENV DISPLAY :1
ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1280x1024
ENV VNC_PW vncpassword

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends --allow-unauthenticated dbus-x11 x11-utils supervisor vim vnc4server xfce4 ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal  lxde x11vnc xvfb && rm -rf /var/lib/apt/lists/*



EXPOSE 5901

ADD .vnc /root/.vnc
ADD .config /root/.config
ADD scripts /root/scripts
RUN chmod +x /root/.vnc/xstartup /etc/X11/xinit/xinitrc /root/scripts/*.sh


#############################################################################
# dev                                                                       #
#############################################################################

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN pip --no-cache-dir install \
        Pillow \
        h5py \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn \
        && \
    python -m ipykernel.kernelspec




##############################################################################
# anaconda python
##############################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends bzip2 ca-certificates libmysqlclient-dev  \
    wget && \
    rm -rf /var/lib/apt/lists/*
RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    /bin/bash Anaconda3-4.2.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm Anaconda3-4.2.0-Linux-x86_64.sh
ENV PATH /opt/conda/bin:$PATH
RUN pip install --upgrade pip
RUN echo "export PYTHON_HOME=/opt/conda" >> ~/.bashrc
RUN echo "export PATH=${PYTHON_HOME}/bin:$PATH" >> ~/.bashrc
# IPYTHON JUPYTER PORTS

# --- DO NOT EDIT OR DELETE BETWEEN THE LINES --- #
# These lines will be edited automatically by parameterized_docker_build.sh. #
# COPY _PIP_FILE_ /
# RUN pip --no-cache-dir install /_PIP_FILE_
# RUN rm -f /_PIP_FILE_

# Install TensorFlow CPU version from central repo

RUN pip --no-cache-dir install \
      https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.2.1-cp35-cp35m-linux_x86_64.whl


# --- ~ DO NOT EDIT OR DELETE BETWEEN THE LINES --- #

# RUN ln -s /usr/bin/python3 /usr/bin/python#

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Copy sample notebooks.

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888
EXPOSE 8000
RUN mkdir /code


#############################################################################
# naver nanum font                                                          #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends fonts-nanum && rm -rf /var/lib/apt/lists/*
RUN apt-get update \
     && apt-get install -y firefox firefox-locale-ko ttf-ubuntu-font-family \
     && apt-get autoclean \
     && apt-get autoremove \
     && rm -rf /var/lib/apt/lists/*

#############################################################################
# pycharm                                                                   #
#############################################################################
RUN mkdir /home/dev
RUN cd /home/dev
WORKDIR /home/dev
RUN wget https://download.jetbrains.com/python/pycharm-community-2017.1.2.tar.gz

RUN tar -xvf pycharm-community-2017.1.2.tar.gz
RUN mv pycharm-community-2017.1.2 pyc
RUN ln -s /home/dev/pyc/bin/pycharm.sh /usr/bin/pycharm
RUN rm -f pycharm-community-2017.1.2.tar.gz

##############################################################################
# etc
##############################################################################
WORKDIR /code
RUN apt-get update && \
    apt-get install -y --no-install-recommends vim git && \
    rm -rf /var/lib/apt/lists/*
COPY run_celery.sh /
COPY run_django.sh /

COPY run_vnc.sh /

##############################################################################
# git
##############################################################################
RUN mkdir /jupyter
RUN cd /jupyter
WORKDIR /jupyter
RUN git clone https://github.com/TensorMSA/tensormsa_jupyter.git /jupyter
WORKDIR /code

#############################################################################
# nlp setting                                                               #
#############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends sudo openjdk-8-jdk libmecab-dev && rm -rf /var/lib/apt/lists/*


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
###########################################################
#                         lightGBM       		  #
###########################################################




RUN apt-get update && apt-get install -y --no-install-recommends cmake python-setuptools && rm -rf /var/lib/apt/lists/*


RUN cd /home/dev
WORKDIR /home/dev
RUN git clone --recursive https://github.com/Microsoft/LightGBM ; cd LightGBM
RUN mkdir build ; cd build
WORKDIR /home/dev/LightGBM/build
RUN cmake .. 
RUN make -j4
###########################################################
#                         pip    			  #
###########################################################
ADD . /code/
ADD requirements.txt /code/
WORKDIR /code
RUN pip install -r requirements.txt
WORKDIR /code
RUN apt-get update && apt-get install -y --no-install-recommends graphviz && rm -rf /var/lib/apt/lists/*
###########################################################
#                         XGBOOST			  #
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

WORKDIR /code


CMD ["/run_jupyter.sh"]

