# TensorMSA : Tensorflow Micro Service Architecture


# Install

<b>History</b> </br>
 - 17.2.3             Initial</br>
 - 17.2.4             Firefox Fix, Chrome Installed, Korean Font Installed</br>
 - 17.3.1             Tensorflow 1.0, RabbitMQ, Vnc Server, Xfce4 Installed  </br>
 - 17.4.11            Tensorflow 1.1(Complie), Neo4j, flower, mecab Installed   </br>
 - 17.8.23            Django Rest, nginx, postgres, celery (official version) composed by Docker-compose</br>

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
 - Docker ce, Docker-Compose (lastest version) on ubuntu 16.04</br>
 - How to install for docker: https://docs.docker.com/engine/installation/ <br>
 - How to install for docker: https://docs.docker.com/compose/install/ <br>
   
   
<b>2.Git clone  </b> </br>
 - Get all source Tensormsa Docker and Tensermsa source recursively.
 ```bash
 git clone --recursive https://github.com/TensorMSA/tensormsa_docker.git
 ```
    
<b>3.Move docker-compose folder </b> </br>
- Move to docker-compose-folder
   ```bash
     cd ./tensormsa_docker/docker_compose_cpu
   ```
   
<b>4.Make docker volume for postgres db </b> </br>
- Make docker volume
   ```bash
     docker volume create pg_data
   ```
- Check volume
 ```bash
    docker volume inspect pg_data
 ```

<b>5.Change DB Connections  </b> </br>
- Locaion : /docker_compose_cpu/tensormsa/hoyai/settings.py
   ```bash
     vi settings.py
     DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql_psycopg2',
            'NAME': 'postgres',
            'USER': 'postgres',
            'PASSWORD': 'postgres',
            'HOST': 'db',
            'PORT': '5432',
        }
    }
   ```
<b>6.Check enviroment parameters and passwords  </b> </br>
- Locaion : /docker_compose_cpu/.env
```bash
  JUPYTER_PASSWORD=1111
  VNC_RESOLUTION=1920x1080
  DISPLAY=:1
  VNC_PW=11111111
```

<b>7.Docker-compose up </b> </br>
- Start Docker-compose up
   ```bash
     docker-compose up 
   ```
   or running background
   ```bash
     docker-compose up -d
   ```
   
<b>8.Scale up Dynamically </b> </br>
- 3 node celery
   ```bash
     docker-compose scale celery=3
     ```
   
<b>5.Run Docker Container </b> </br>
   - Changes Resolution for vnc = VNC_RESOLUTION=<b>"1920x1080"</b> </br>
   ```bash
   
     docker run -itd --env="VNC_RESOLUTION=1920x1080" --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name hoyai_dev -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 8888:8888 -p 5901:5901 hoyai/hoyai_dev_docker:squashed2
     
     docker run -itd --env="VNC_RESOLUTION=1920x1080" --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --volume="/hoya_src_root:/hoya_src_root" --volume="/hoya_model_root:/hoya_model_root" --volume="/hoya_str_root:/hoya_str_root" --volume="/hoya_data_root:/hoya_data_root" --name hoyai_dev -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 8888:8888 -p 5901:5901 hoyai/hoyai_dev_docker:squashed2
     
     gpu
    nvidia-docker run -itd --env="VNC_RESOLUTION=1920x1080" --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name hoyai_dev -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 8888:8888 -p 5901:5901 hoyai/hoyai_gpu_dev_docker:v1.0
    
    ai 137
 docker run -itd --env="VNC_RESOLUTION=1920x1080" --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --volume="/data1/hoyai_playground:/home/dev/hoyai_playground"  --volume="/data1/hoya_src_root:/hoya_src_root" --volume="/data1/hoya_model_root:/hoya_model_root" --volume="/data1/hoya_str_root:/hoya_str_root" --name hoyai_dev_2 -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 8888:8888 -p 5901:5901 -p 5555:5555 hoyai/hoyai_dev_docker:flower


     
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
   - Click vnc and input your ip(port : XXXX) <br>
   <b>- Passwd : *********</b><br>
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
 
 docker build --rm -t hoyai/hoyai_dev_docker:v2.1 .
 
 pip install docker-squash
 
 docker history hoyai/hoyai_dev_docker:v2.1
 select image id for starting point
 docker-squash -f f49eec89601e -t hoyai/hoyai_dev_docker:squashed hoyai/hoyai_dev_docker:v2.0

 
 docker-squash -f f49eec89601e -t hoyai/hoyai_dev_docker:squashed hoyai/hoyai_dev_docker
 ```

<b>11. Docker Container size up(1.7.1 RHEL)</b> </br>
```bash
service docker stop
vi /etc/sysconfig/docker
other_args="--storage-driver=devicemapper --storage-opt dm.basesize=20G"
rm -Rf /var/lib/docker (다 지워짐 조심)
service docker start or reboot
이미지를 새로 받아야함
```

b>12. Docker rebuild setup list</b> </br>
```
1. jenkins git pull
2. jenkins jupyter git pull
3. inside docker : passwd root
4. inside docker : /home/dev 에서 ln -s로 hoya_src_root연결
5. inside docker : /home/dev에서 jupyter notebook 실행
6. inside docker : start_hoyai.sh 복사
7. inside docker : ./start_hoyai.sh 6 8 10 으로 서버 스타트
8. jupyter rule setup
9. tensorboard --logdir=/hoya_model_root
```


b>13. Docker rebuild setup list</b> </br>
```
su postgres


pg_dump -Fc tensormsa > /hoya_src_root/postgres_backup/postgres_backup_07_10_2.dump

cp /var/nfs/hoya_src_root/postgres_backup/postgres_backup_07_10_2.dump ./


pg_restore -c -d tensormsa tensormsa.dump

GRANT ALL ON schema public TO tfmsauser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tfmsauser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO tfmsauser;
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
   
 <b>11.Docker VNC </b> </br>   
   Browser it doesn't crash
   ```bash
   docker run -itd -p 6080:80 -p 5902:5900 -e VNC_PASSWORD=mypassword hoyai/ubuntu_vnc --name hoyai_documents
   ```
   ```bash
   http://xxx.xx.xx.xxx:6080
   ```
