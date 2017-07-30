FROM ubuntu:16.04

MAINTAINER Craig Citro <craigcitro@google.com>

# Pick up some TF dependencies
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
RUN mkdir /code
ADD requirements.txt /code/
WORKDIR /code
RUN pip install -r requirements.txt
ADD . /code/
WORKDIR /code
##############################################################################
# etc
##############################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends vim && \
    rm -rf /var/lib/apt/lists/*
COPY run_celery.sh /

CMD ["/run_jupyter.sh"]

