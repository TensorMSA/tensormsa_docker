
# kcit edication docker

##  Get Docker
https://docs.docker.com/engine/installation/


## Get Docker-compose
https://github.com/docker/compose/releases

curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# Git clone
cd ~
git clone 

## Resolution Change and change password
cd ~/tensormsa_docker/kict_edu_docker

vi .env 

VNC_RESOLUTION=1900x1028
JUPYTER_PASSWORD=????


## Docker-compose up
cd ~/tensormsa_docker/kict_edu_docker

docker-compose up


## Connect to jupyter
https://xx.xx.xx.xx:8888
password : 1111
