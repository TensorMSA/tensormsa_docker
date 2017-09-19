
# sk plenet edication docker

## Remove & Get Docker
https://docs.docker.com/engine/installation/

docker rm -f containerId

docker rmi -f dockerImage

apt-get -f install

sudo apt-get remove docker*

curl -s https://get.docker.com/ | sudo sh


## Get Docker-compose
https://github.com/docker/compose/releases

curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose


## Resolution Change
cd /home/ubuntu/skp_edu_docker/

vi .env 

VNC_RESOLUTION=1900x1028


## Docker-compose up
cd /home/ubuntu/skp_edu_docker/

docker volume create --name=pg_data

docker-compose up


## Docker Celery Add
docker-compose scale celery=3


## Docker Celery Setup Change
docker exec -it dockerId bash

move root folder

vi run_celery.sh

## Docker Celery Setup Change Script
cd /home/dev/tensormsa

celery -A hoyai worker -l info
