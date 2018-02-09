# TensorMSA : Tensorflow Micro Service Architecture


# Install

<b>History</b> </br>
 - 17.2.3 : Initial</br>
 - 17.2.4 : Firefox Fix, Chrome Installed, Korean Font Installed</br>
 - 17.3.1 : Tensorflow 1.0, RabbitMQ, Vnc Server, Xfce4 Installed  </br>
 - 17.4.11: Tensorflow 1.1(Complie), Neo4j, flower, mecab Installed   </br>
 - 17.8.23 : Django Rest, nginx, postgres, celery (official version) composed by Docker-compose</br>
 - 18.2.9 : Single Cpu Developer Vesion update
 - 18.2.9 : Add Opencv Compile Version , Dlib, Never Crashed Chrome

<b>Summeries</b> </br>
 - python 3.5
 - conda
 - Tensorflow v1.1
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
- Make docker volume (Run as root)
   ```bash
     docker volume create --name=pg_data
   ```
- Check volume
 ```bash
    docker volume inspect pg_data
 ```

<b>5.Docker-compose up (>= v1.13) </b> </br>
- Start Docker-compose up
   ```bash
     docker-compose up -d
   ```

   
<b>6.Django make static files and migrate </b> </br>
- Make static files and migrate
   ```bash
     docker-compose run web python /home/dev/tensormsa/manage.py collectstatic
        enter 'Yes'
     docker-compose run web python /home/dev/tensormsa/manage.py makemigrations
     docker-compose run web python /home/dev/tensormsa/manage.py migrate
        
        If you need chatbot funtion?
     docker-compose run web python /home/dev/tensormsa/manage.py makemigrations chatbot
     docker-compose run web python /home/dev/tensormsa/manage.py migrate chatbot
   ```

   
<b>7.Scale up Dynamically </b> </br>
- 3 node celery
   ```bash
     docker-compose scale celery=3
   ```
   
<b>8.Testing </b> </br>
- <ip:8018> for jupyter
- <ip:5555> for celery
- <ip:8000> for django
- <ip:5901> for vnc


<b>Check 1. Change DB Connections  </b> </br>
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
   
<b>Check 2. Check enviroment parameters and passwords  </b> </br>
- Locaion : /docker_compose_cpu/.env
```bash
  JUPYTER_PASSWORD=your password
  VNC_RESOLUTION=1920x1080
  DISPLAY=:1
  VNC_PW=your password
```

<b>Check 3. Docker container volumne resize(ubuntu 16.04, docker-ce 17.09)  </b> </br>

```bash
  sudo service docker stop
  sudo dockerd --storage-opt dm.basesize=50G
  docker info
  sudo service docker stop
```

<b> etc. Single Docker run command
```bash
nvidia-docker run -itd --env-file=".env" --name hoyai_dev -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 5901:5901 hoyai/tensormsa_dev_gpu_single:v1.0
docker run -itd --env-file=".env" --name hoyai_dev -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 5901:5901 hoyai/tensormsa_dev_cpu_single:v1.0
 
 docker run -itd --runtime=nvidia --env-file=".env" --name hoyai_dev -p 8989:8989 -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 5901:5901 --volume="/home/parksc/hoya_data/hoya_src_root:/hoya_src_root" --volume="/home/parksc/hoya_data/hoya_model_root:/hoya_model_root" --volume="/home/parksc/hoya_data/hoya_str_root:/hoya_str_root" --device=/dev/video0 hoyai/tensormsa_dev_gpu_single:v0.9
 
```

![celery](./img/celery.jpg)
![juppter](./img/jupyter.jpg)
![vnc](./img/vnc.jpg)

<b> Developer Version Single Docker

```bash
# Docker install
sudo apt-get update
 
sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -    

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update   

sudo apt-get install docker-ce

# TensorMsa Docker git Clone
sudo mkdir /home/dev

cd /home/dev 

sudo git clone https://github.com/TensorMSA/tensormsa_docker.git

cd /home/dev/tensormsa_docker/docker_cpu


# Lunch Tensormsa Docker
docker run -it --env-file=.env -e DISPLAY=$DISPLAY --shm-size=256m -v /tmp/.X11-unix:/tmp/.X11-unix --name hoyai_dev --privileged -p 8989:8989 -p 5672:5672 -p 2266:2266 -p 5432:5432 -p 8000:8000 -p 6006:6006 -p 5901:5901 -p 5902:5902 --volume="/hoya_data/hoya_src_root:/hoya_src_root" --volume="/hoya_data/hoya_model_root:/hoya_model_root" --volume="/hoya_data/hoya_str_root:/hoya_str_root" hoyai/hoyai_dev_cpu_single:v1.02


# Register Service for Tensorsa Docker
cd /etc/systemd/system/
vi docker_hoyai.service

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

For Start
sudo systemctl enable docker_hoyai.service
sudo systemctl start docker_hoyai.service

For Stop
sudo systemctl stop docker_hoyai.service
sudo systemctl disable docker_hoyai.service
 
```

