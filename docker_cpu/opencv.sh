
$ cd ~
$ wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.1.0.zip
$ unzip opencv.zip

cd ~

unzip opencv.zip

$ wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.1.0.zip
$ unzip opencv_contrib.zip



cd ~

unzip opencv.zip

$ wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.1.0.zip
$ unzip opencv_contrib.zip



cd ~/opencv-3.1.0/
$ mkdir build
$ cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -DWITH_CUDA=OFF \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D BUILD_opencv_hdf=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.1.0/modules \
    -D BUILD_EXAMPLES=ON ..

make -j
make install
ldconfig


docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --runtime=nvidia --name hoyai_dev -p 8989:8989 -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 5901:5901 --volume="/home/Hyunsh/hoya_data/hoya_src_root:/hoya_src_root" --volume="/home/Hyunsh/hoya_data/hoya_model_root:/hoya_model_root" --volume="/home/Hyunsh/hoya_data/hoya_str_root:/hoya_str_root" --device=/dev/video0 hoyai/tensormsa_dev_gpu_single:v1.02 /bin/bash


wget https://www.ffmpeg.org/releases/ffmpeg-3.1.11.tar.gz

export PYTHONPATH=/home/dev/xgboost/python-package:${PYTHONPATH}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/include


cp /root/opencv/build/lib/python3/cv2.cpython-36m-x86_64-linux-gnu.so /opt/conda/lib/python3.6/site-packages/cv2




apt-get update
apt-get upgrade

apt-get install build-essential cmake git pkg-config
apt-get install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
apt-get install libgtk2.0-dev
apt-get install libatlas-base-dev gfortran




cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D WITH_CUDA=ON \
-D INSTALL_C_EXAMPLES=ON \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D BUILD_EXAMPLES=ON \
-DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
-DPYTHON_EXECUTABLE=$(which python3.6) \
-DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. 

make -j8
make install

