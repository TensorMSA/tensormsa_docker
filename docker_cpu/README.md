# TensorMSA : Tensorflow Micro Service Architecture


# Install

<b>History</b> </br>
 - 17.2.3             Initial</br>
 - 17.2.4             Firefox Fix, Chrome Installed, Korean Font Installed</br>
 - 17.3.1             Tensorflow 1.0, RabbitMQ, Vnc Server, Xfce4 Installed  </br>
 - 17.4.11            Tensorflow 1.1(Complie), Neo4j, flower, mecab Installed   </br>

<b>Summeries</b> </br>
 - python 3.5
 - conda
 - Tensorflow r0.12
 - Django
 - postgres 9.6
 - Pycharm Comunity 
 - Chrome
 - python packages for hoyai
 - pgadmin3
 - rabbit mq
 - hdfview
 - vnc xfce4 setup
 - Neo4j
 - mecab</br>
 
   
<b>1.Prerequisite </b> </br>
   - Docker 1.13 on ubuntu 16.04</br>
   - How to install : https://docs.docker.com/engine/installation/linux/ubuntu/ <br>
   - Add 127.0.0.1 ip-xxx-xx-x-xx to /etc/hosts<br>
   ```bash
   - unset DISPLAY
    ```
   
<b>2.User add ubuntu </b> </br>
   ```bash
     sudo groupadd docker
     sudo gpasswd -a ubuntu docker
   ```
   * Test command : docker ps(By ubuntu id) - restart AWS 

<b>3.Download Docker Images </b> </br>
   ```bash
     docker pull hoyai/hoyai_dev_docker:squashed
   ```
<b>4.Run Docker Container </b> </br>
   - Changes Resolution for vnc = VNC_RESOLUTION=<b>"1920x1080"</b> </br>
   ```bash
   
     docker run -itd --env="VNC_RESOLUTION=1920x1080" --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name hoyai_dev -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 8888:8888 -p 5901:5901 hoyai/hoyai_dev_docker:squashed
   ```

<b>5. Register Docker Service</b> </br>
   ```bash
     cd /etc/systemd/system/
     vi docker_hoyai.service     
   ```

   - docker_hoyai.service
   ```bash
     [Unit]
     Description=hoyai container
     Requires=docker.service
     After=docker.service

     [Service]
     Restart=always
     ExecStart=/usr/bin/docker start -a hoyai_dev
     ExecStop=/usr/bin/docker stop -t 2 hoyai_dev

     [Install]
     WantedBy=default.target
   ``` 

   - Service enable & start</br>
   ```bash
      sudo systemctl enable docker_hoyai.service
      
      sudo systemctl start docker_hoyai.service
   ```
   - Service disable & stop</br>
   ```bash
      sudo systemctl disable docker_hoyai.service
      
      sudo systemctl stop docker_hoyai.service
   ```

<b>6. Restart aws</b> </br>
   - Check for hoyai_dev_docker started after aws reboot<br>
  ```bash
     
     docker ps 
  ```  

<b>7. Install VNC</b> </br>
   - Go to  chrome app store<br>
   - Find VNC Viewer for Google Chrome<br>
   <img src="https://github.com/TensorMSA/hoyai_docker/blob/master/img/VNC_CHORME_2.JPG" width="750"/>

<b>7. Connect VNC</b> </br>
   - Make New tab in chrome<br>
   - Find apps icon on top of screen<br>
   - Click vnc and input your ip(port : 5901) <br>
   <b>- Passwd : vncpasswd</b><br>
   <img src="https://github.com/TensorMSA/hoyai_docker/blob/master/img/NEW_TAB_3.JPG" width="750"/><br>
   
<b>8. ETC</b> </br>
   - pycharm.sh &<br>
   - firefox<br>
   - pgadmin3<br>

<b>9. Merge Another Repository to My Repository</b> </br>
   - Make git repository for docker auto build
   - Add remode repository
   ```bash
   git remote add hoyai_docker https://github.com/TensorMSA/hoyai_docker.git
   ```
   ```bash
   cd hoyai_dev_docker/
   
   git pull hoyai_docker

   git branch -d dd
   git checkout -b dd hoyai_docker/master

   git checkout master
   git merge dd
   git push
   ```
 <b>10. Squash Docker images</b> </br>
 ```bash
 pip install docker-squash
 docker-squash -f f49eec89601e -t hoyai/hoyai_dev_docker:squashed hoyai/hoyai_dev_docker
 ```

---------------------------before--------------------------------------------------------<br>
<b>1.Install Xming </b> </br>
   - download Xming : https://sourceforge.net/projects/xming/ </br>
   - install 

<b>2.Install Putty</b> </br>
   - install putty :  http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html? 

<b>3.Connect AWS EC2 Instance</b> </br>
   - .....</br>

<b>4.Git clone</b> </br>

<b>5.Docker build</b> </br>
   ```bash
     docker build --rm -t hoyai/client:v0.1 .
   ```
   - You can change name and version [hoyai/client:v0.1] </br>
   
<b>6.Docker run</b> </br>
   ```bash
     docker run -itd --name hoyai_dev -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 8888:8888 --volume /root/data/:/root/lib/ hoyai/client:v0.1
     
     docker run -itd  --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name hoyai_dev -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 8888:8888 --volume /root/data/:/root/lib/ hoyai/client:v0.1
     
docker run -itd  --env="VNC_RESOLUTION=1920x1080" --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name hoyai_dev -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 8888:8888 -p 5901:5901 --volume /root/data/:/root/lib/ hoyai/client:v0.2   
   ```
<b>7.Connect hoyai_dev directly and Change root password</b> </br>
   ```bash
      docker exec -it hoyai_dev bash
   ```
   ```bash
       passwd root
   ```
 
<b>8.Connect hoyai_dev by SSH </b> </br>
   - putty -> connection -> ssh -> X11 -> Enable X11 forwarding check
   - Connect AWS, Port : 2266 

<b>9.Run Pycharm </b> </br>
   ```bash
       /home/dev/pyc/bin/pycharm.sh &
   ```
   
 <b>10.Run Chrome </b> </br>
   ```bash
       /usr/bin/google-chrome --no-sandbox
   ```




docker run -itd --env="VNC_RESOLUTION=1920x1080" --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name hoyai_dev -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 8888:8888 -p 5901:5901 --volume /root/data/:/root/lib/ hoyai/client:v0.2

docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --runtime=nvidia --env-file=".env" --name hoyai_dev -p 8989:8989 -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 5901:5901 --volume="/home/Hyunsh/hoya_data/hoya_src_root:/hoya_src_root" --volume="/home/Hyunsh/hoya_data/hfoya_model_root:/hoya_model_root" --volume="/home/Hyunsh/hoya_data/hoya_str_root:/hoya_str_root" --device=/dev/video0 hoyai/tensormsa_dev_gpu_single:v1.02 /bin/bash

docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --runtime=nvidia --name hoyai_dev -p 8989:8989 -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 5901:5901 --volume="/home/Hyunsh/hoya_data/hoya_src_root:/hoya_src_root" --volume="/home/Hyunsh/hoya_data/hoya_model_root:/hoya_model_root" --volume="/home/Hyunsh/hoya_data/hoya_str_root:/hoya_str_root" --device=/dev/video0 hoyai/tensormsa_dev_gpu_single:v1.02 /bin/bash

docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --runtime=nvidia --name hoyai_dev -p 8989:8989 -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 5901:5901 --volume="/home/Hyunsh/hoya_data/hoya_src_root:/hoya_src_root" --volume="/home/Hyunsh/hoya_data/hoya_model_root:/hoya_model_root" --volume="/home/Hyunsh/hoya_data/hoya_str_root:/hoya_str_root" --device=/dev/video0 hoyai/tensormsa_dev_gpu_single:v1.02 /bin/bash

docker run -ti --rm
-e DISPLAY=$DISPLAY
-v /tmp/.X11-unix:/tmp/.X11-unix
hoyai/tensormsa_dev_gpu_single:v1.02 /bin/bash

docker run -ti --rm
-e DISPLAY=$DISPLAY
-v /tmp/.X11-unix:/tmp/.X11-unix
firefox /bin/bash

apt-get remove vnc4server

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends supervisor vim vnc4server xfce4 ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && rm -rf /var/lib/apt/lists/*

docker cp /usr/share/ca-certificates/extra/POSCOICT_CA_256.cer 90:/

mkdir /usr/share/ca-certificates/extra

cp POSCOICT_CA_256.cer /usr/share/ca-certificates/extra/.

vi /etc/ca-certificates.conf
extra/POSCOICT_CA_256.cer

dpkg-reconfigure ca-certificates

install libgtk2.0-dev and pkg-config
apt-get install libqt4-dev

xhost local:root

cmake -DBUILD_TIFF=ON
-DBUILD_opencv_java=OFF
-DWITH_CUDA=OFF
-DWITH_QT=ON
-DENABLE_AVX=ON
-DWITH_OPENGL=ON
-DWITH_OPENCL=ON
-DWITH_IPP=ON
-DWITH_TBB=ON
-DWITH_EIGEN=ON
-DWITH_V4L=ON
-DBUILD_TESTS=OFF
-DBUILD_PERF_TESTS=OFF
-DCMAKE_BUILD_TYPE=RELEASE
-DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)")
-DPYTHON_EXECUTABLE=$(which python3.6)
-DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")
-DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \

dbus-uuidgen --ensure=/etc/machine-id

1a411afb4f9a7a5e82dc073a5a45a575

vi /etc/machine-id

dbus-uuidgen > /etc/machine-id

echo "export PATH=${PYTHON_HOME}/bin:$PATH" >> ~/.bashrc



docker run -it -e DISPLAY=$DISPLAY --env-file=".env" -v /tmp/.X11-unix:/tmp/.X11-unix --runtime=nvidia --name hoyai_dev -p 8989:8989 -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 5901:5901 -p 8888:8888 --volume="/home/parksc/hoya_data/hoya_src_root:/hoya_src_root" --volume="/home/parksc/hoya_data/hoya_model_root:/hoya_model_root" --volume="/home/parksc/hoya_data/hoya_str_root:/hoya_str_root" --device=/dev/video0 hoyai/tensormsa_dev_gpu_single:v1.06



cmake -DBUILD_TIFF=ON \
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
  -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-3.2.0/modules \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.6) \
  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. 

vlc rtsp://your_url

make -j8 install


rm CMakeCache.txt


vlc rtsp://admin:888888@192.168.81.88:10554/udp/av0_0

192.168.81.88:58984

cp /opencv-3.3.0/cmake_binary/lib/python3/cv2.cpython-36m-x86_64-linux-gnu.so /opt/conda/lib/python3.6/site-packages/cv2/



sudo apt-get -y install libopencv-dev build-essential cmake git libgtk2.0-dev pkg-config python-dev python-numpy libdc1394-22 libdc1394-22-dev libjpeg-dev libpng12-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev


 libxvidcore-dev x264 v4l-utils unzip



cv2.getBuildInformation()
cv2.getBuildInfomation()


cmake -DBUILD_TIFF=ON \
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
  -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-3.2.0/modules \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.6) \
  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. 



apt-get install libavresample-dev

apt install libcanberra-gtk-module libcanberra-gtk3-module print(get_python_lib())") ..


libavcodec57 libavdevice-dev libavfilter-dev libavfilter-extra libavformat-dev


libavformat57 libavresample-dev libavresample3 libavutil-dev libavutil55 libpostproc-dev

libswresample-dev libswresample2 libswscale-dev libswscale4
fmpeg
ffmpeg-dbgsym: Debug symbols for ffmpeg
ffmpeg-doc: Documentation of the FFmpeg multimedia framework
apt-get install libav-tools libavcodec-dev libavcodec-extra libavcodec-extra57
libavcodec-extra57-dbgsym: debug symbols for libavcodec-extra57
libavcodec57: FFmpeg library with de/encoders for audio/video codecs - runtime files
libavcodec57-dbgsym: debug symbols for libavcodec57

libavdevice-dev: FFmpeg library for handling input and output devices - development files
libavdevice57: FFmpeg library for handling input and output devices - runtime files
libavdevice57-dbgsym: Debug symbols for libavdevice57
libavfilter-dev: FFmpeg library containing media filters - development files
libavfilter-extra: FFmpeg library with extra filters (metapackage)
libavfilter-extra6: FFmpeg library with extra media filters - runtime files
libavfilter-extra6-dbgsym: Debug symbols for libavfilter-extra6
libavfilter6: FFmpeg library containing media filters - runtime files
libavfilter6-dbgsym: debug symbols for libavfilter6
libavformat-dev: FFmpeg library with (de)muxers for multimedia containers - development files
libavformat57: FFmpeg library with (de)muxers for multimedia containers - runtime files
libavformat57-dbgsym: Debug symbols for libavformat57
libavresample-dev: FFmpeg compatibility library for resampling - development files
libavresample3: FFmpeg compatibility library for resampling - runtime files
libavresample3-dbgsym: debug symbols for libavresample3
libavutil-dev: FFmpeg library with functions for simplifying programming - development files
libavutil55: FFmpeg library with functions for simplifying programming - runtime files
libavutil55-dbgsym: Debug symbols for libavutil55
libpostproc-dev: FFmpeg library for post processing - development files
libpostproc54: FFmpeg library for post processing - runtime files
libpostproc54-dbgsym: debug symbols for libpostproc54
libswresample-dev: FFmpeg library for audio resampling, rematrixing etc. - development files
libswresample2: FFmpeg library for audio resampling, rematrixing etc. - runtime files
libswresample2-dbgsym: Debug symbols for libswresample2
libswscale-dev: FFmpeg library for image scaling and various conversions - development files
libswscale4: FFmpeg library for image scaling and various conversions - runtime files
libswscale4-dbgsym: Debug symbols for libswscale4 

cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON ..


cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -DWITH_CUDA=OFF \
        -DWITH_FFMPEG=OFF \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON \
	  -DCMAKE_BUILD_TYPE=RELEASE \
	  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
	  -DPYTHON_EXECUTABLE=$(which python3.6) \
	  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
	-DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. 



echo deb http://www.deb-multimedia.org testing main non-free \
                  >>/etc/apt/sources.list



docker cp POSCOICT_CA_256.cer fb:/
mkdir /usr/share/ca-certificates/extra
mkdir /usr/share/ca-certificates/extra
mkdir /usr/share/ca-certificates/extra



apt-get install deb-multimedia-keyring
apt-get remove deb-multimedia-keyring



wget https://github.com/opencv/opencv_contrib/archive/3.3.0.zip
unzip 3.0.0.zip

wget https://github.com/opencv/opencv/archive/3.3.0.zip

git clone 

cmake -DBUILD_TIFF=ON \
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
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.6) \
  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. 


cmake  -D CMAKE_BUILD_TYPE=RELEASE \
-DWITH_FFMPEG=ON \
  	-DWITH_CUDA=OFF \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D BUILD_EXAMPLES=ON \
  -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-3.0.0/modules \
  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.6) \
  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. 


cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON \

cp /opencv-3.0.0/cmake_binary/lib/python3/cv2.cpython-36m-x86_64-linux-gnu.so /opt/conda/lib/python3.6/site-packages/cv2/



https://www.ffmpeg.org/releases/ffmpeg-2.7.7.tar.bz2


wget https://www.ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar jxvf ffmpeg-snapshot.tar.bz2

cd ffmpeg
./configure --prefix=/usr/
time make -j 8
cat RELEASE
sudo checkinstall

dpkg --install ffmpeg_*.deb



./ffmpeg -i rtsp://admin:888888@192.168.81.88:10554/udp/av0_0 -vcodec copy /abcd.mp4

ffmpeg -i rtsp://admin:888888@192.168.1.16:10554/udp/av0_0 -vcodec copy /4.mp4
  libavutil      56.  7.100 / 56.  7.100
  libavcodec     58.  9.100 / 58.  9.100
  libavformat    58.  3.100 / 58.  3.100
  libavdevice    58.  0.100 / 58.  0.100
  libavfilter     7.  8.100 /  7.  8.100
  libswscale      5.  0.101 /  5.  0.101
  libswresample   3.  0.101 /  3.  0.101


    FFMPEG:                      YES
      avcodec:                   YES (ver 56.60.100)
      avformat:                  YES (ver 56.40.101)
      avutil:                    YES (ver 54.31.100)
      swscale:                   YES (ver 3.1.101)
      avresample:                NO



cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -DWITH_FFMPEG=ON \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D INSTALL_C_EXAMPLES=OFF \
      -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib-3.3.0/modules \
      -D PYTHON_EXECUTABLE=/opt/conda/bin/python3.6 \
      -D BUILD_EXAMPLES=ON ..


--     Interpreter:                 /opt/conda/bin/python3 (ver 3.6.2)
--     Libraries:                   /opt/conda/lib/libpython3.6m.so (ver 3.6.2)
--     numpy:                       /opt/conda/lib/python3.6/site-packages/numpy/core/include (ver 1.12.1)
--     packages path:               lib/python3.6/site-packages
-- 
--   Python (for build):            /opt/conda/bin/python3

cmake -DBUILD_TIFF=ON \
  -DWITH_FFMPEG=ON \
  -DWITH_CUDA=OFF \
  -DWITH_QT=ON \
  -DENABLE_AVX=ON \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -D BUILD_opencv_hdf=OFF \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DOPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.1.0/modules \
  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.6) \
  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. 




cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D WITH_CUDA=OFF \
-D WITH_TBB=OFF \
-D WITH_IPP=OFF \
-D WITH_1394=OFF \
-D BUILD_WITH_DEBUG_INFO=OFF \
-D BUILD_DOCS=OFF \
-D INSTALL_C_EXAMPLES=ON \
-D INSTALL_PYTHON_EXAMPLES=ON \

ma
-D BUILD_EXAMPLES=OFF \
-D BUILD_TESTS=OFF \
-D BUILD_PERF_TESTS=OFF \
-D ENABLE_NEON=ON \
-D WITH_QT=ON \
-D WITH_OPENGL=ON \
-D OPENCV_EXTRA_MODULES_PATH=/opencv/opencv_contrib/modules \
-D WITH_V4L=ON  \
-D WITH_FFMPEG=ON \
-D WITH_XINE=ON \
-D CMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
-D PYTHON_EXECUTABLE=$(which python3.6) \
-D PYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-D PYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
..

--   Python 3:
--     Interpreter:                 /opt/conda/bin/python3 (ver 3.6.2)
--     Libraries:                   /opt/conda/lib/libpython3.6m.so (ver 3.6.2)
--     numpy:                    vi   /opt/conda/lib/python3.6/site-packages/numpy/core/include (ver 1.12.1)
--     packages path:               lib/python3.6/site-packages

make -j8 install

apt-get install libavresample-dev
출처: http://driz2le.tistory.com/218 [홀로 떠나는 여행]


아래 파일을 오픈합니다.

~/opencv/opencv_contrib-3.2.0/modules/freetype/CMakeLists.txt


해당 파일의 22번째 줄을 주석처리하고 아래 파란색 명령을 추가합니다.

즉,  freetype2_LIBRARIES와 harfbuzz_LIBRARIES이 제대로된 경로를 못찾아주어서 발생하는 오류입니다.


if( FREETYPE_FOUND AND HARFBUZZ_FOUND )

#  ocv_define_module(freetype opencv_core opencv_imgproc PRIVATE_REQUIRED ${freetype2_LIBRARIES} ${harfbuzz_LIBRARIES} WRAP python)

   ocv_define_module(freetype opencv_core opencv_imgproc PRIVATE_REQUIRED ${FREETYPE_LIBRARIES} ${HARFBUZZ_LIBRARIES} WRAP python)

   ocv_include_directories( ${FREETYPE_INCLUDE_DIRS} ${HARFBUZZ_INCLUDE_DIRS}     

)


출처: http://driz2le.tistory.com/218 [홀로 떠나는 여행]


git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg

cd ffmpeg

./configure --enable-nonfree --enable-pic --enable-shared

make

sudo make install


ldconfig

cp /opencv/cmake_binary/lib/python3/cv2.cpython-36m-x86_64-linux-gnu.so /opt/conda/lib/python3.6/site-packages/cv2/



wget -O ffmpeg-snapshot.tar.bz2 http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2


tar xjvf ffmpeg-snapshot.tar.bz2

https://www.ffmpeg.org/releases/ffmpeg-3.1.11.tar.xz

wget https://www.ffmpeg.org/releases/ffmpeg-3.1.11.tar.gz

tar -xvzf 

./configure --prefix=/usr/local --enable-gpl --enable-swscale --enable-shared --enable-postproc --enable-avfilter-lavf

PATH="/ffmpeg/bin:$PATH" PKG_CONFIG_PATH="/ffmpeg/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="/ffmpeg/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I/ffmpeg/ffmpeg_build/include" \
  --extra-ldflags="-L/ffmpeg/ffmpeg_build/lib" \
  --extra-libs=jvf-lpthread -lm" \
  --bindir="/ffmpeg/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree  

apt-get install libx264-dev
apt-get install libx265-dev
apt-get install libfdk-aac-dev
apt-get install pkg-config
apt-get install libass-dev
apt-get install libtheora-dev



cd ~/ffmpeg_sources && \
wget -O ffmpeg-snapshot.tar.bz2 http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
tar xjvf ffmpeg-snapshot.tar.bz2 && \
cd ffmpeg && \
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --extra-libs="-lpthread -lm" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree && \
PATH="$HOME/bin:$PATH" make && \
make install
hash -r



cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/opt/conda \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
	-D WITH_CUDA=OFF \
	-D BUILD_EXAMPLES=ON ..



cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/opt/conda \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
	-D WITH_CUDA=OFF \
        -D WITH_LIBV4L=OFF \
	-D BUILD_EXAMPLES=ON ..



cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
-D WITH_LIBV4L=ON \
-D ENABLE_PRECOMPILED_HEADERS=OFF \
-D WITH_V4L=OFF \
-D WITH_CUDA=OFF \
-D BUILD_PNG=OFF \
-D BUILD_EXAMPLES=ON ..


/opt/conda/include/


 
fatal error: /opt/conda/include/libpng/png.h: No such file or directory


/usr/include/png.h


cp /opt/conda/include/png.h /opt/conda/include/libpng/png.h

cp /opt/conda/include/pn* /opt/conda/include/libpng/

rm /opt/conda/include/libpng/png.h
:q
x

In file included from /opencv/build/CMakeFiles/CMakeTmp/CheckIncludeFile.c:1:0:
/opt/conda/include/libpng/png.h:366:27: fatal error: cd.h: No such file or directory



export C_INCLUDE_PATH=/usr/local/lib:/usr/local/include/libpng12:$C_INCLUDE_PATH
export LIBRARY_PATH=/usr/local/lib:/usr/local/include/libpng12:$LIBRARY_PATH

ls -a /opt/conda/include/libpng/png.h

make -j4

/opt/conda/include/libpng/png.h 

ln -sf /opt/conda/include/libpng16/*.h /opt/conda/include/libpng

ls /opt/conda/include/libpng16/*.h
 Could NOT find PNG (missing:  PNG_LIBRARY PNG_PNG_INCLUDE_DIR)

sudo ln -sf /usr/include/libavcodec/*.h /usr/include/ffmpeg && \
sudo ln -sf /usr/include/libavformat/*.h /usr/include/ffmpeg && \
sudo ln -sf /usr/include/libswscale/*.h /usr/include/ffmpeg && \
Fvose

apt-get purge  libopencv* python-opencv
sudo apt-get autoremove



sudo apt-get install libopenblas-dev liblapack-dev libatlas-base-dev这句执行的


vc = cv2.VideoCapture(0)



cp /opencv-3.1.0/cmake_binary/lib/python3/cv2.cpython-36m-x86_64-linux-gnu.so /opt/conda/lib/python3.6/site-packages/cv2


docker cp /usr/share/ca-certificates/extra/POSCOICT_CA_256.cer b2:/

mkdir /usr/share/ca-certificates/extra

cp POSCOICT_CA_256.cer /usr/share/ca-certificates/extra/.

vi /etc/ca-certificates.conf
extra/POSCOICT_CA_256.cer

dpkg-reconfigure ca-certificates



apt-get update
apt-get upgrade

apt-get install build-essential cmake git pkg-config
apt-get install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
apt-get install libgtk2.0-dev
apt-get install libatlas-base-dev gfortran


	

