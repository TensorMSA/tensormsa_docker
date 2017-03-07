#!/bin/bash
set -e
source ${PG_APP_HOME}/functions

[[ ${DEBUG} == true ]] && set -x

# allow arguments to be passed to postgres
if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --
elif [[ ${1} == postgres || ${1} == $(which postgres) ]]; then
  EXTRA_ARGS="${@:2}"
  set --
fi

# default behaviour is to launch postgres
if [[ -z ${1} ]]; then
  map_uidgid

  create_datadir
  create_certdir
  create_logdir
  create_rundir

  set_resolvconf_perms

  configure_postgresql
  echo "Starting ssh demon"
  service ssh start 

  echo "Starting PostgreSQL ${PG_VERSION}..."
  exec start-stop-daemon --start --chuid ${PG_USER}:${PG_USER} \
    --exec ${PG_BINDIR}/postgres -- -D ${PG_DATADIR} ${EXTRA_ARGS}&

else
  exec "$@"
fi

#resolve_vnc_connection
VNC_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
VNC_PORT="590"${DISPLAY:1}
#NO_VNC_PORT="690"${DISPLAY:1}

##change vnc password
echo "change vnc password!"
(echo $VNC_PW && echo $VNC_PW) | vncpasswd

##start vncserver and noVNC webclient
#$NO_VNC_HOME/utils/launch.sh --vnc $VNC_IP:$VNC_PORT --listen $NO_VNC_PORT &
vncserver -kill :1 && rm -rfv /tmp/.X* ; echo "remove old vnc locks to be a reattachable container"
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION
sleep 1
##log connect options
echo -e "\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
echo -e "\nnoVNC HTML client started:\n\t=> connect via http://$VNC_IP:$NO_VNC_PORT/vnc_auto.html?password=..."

for i in "$@"
do
case $i in
    # if option `-t` or `--tail-log` block the execution and tail the VNC log
    -t|--tail-log)
    echo -e "\n------------------ /root/.vnc/*$DISPLAY.log ------------------"
    tail -f /root/.vnc/*$DISPLAY.log
    ;;
    *)
    # unknown option ==> call command
    exec $i
    ;;
esac
done

echo -e "\n------------------ bash auto completion ------------------"
#/root/scripts/bash_auto_completion.sh

echo -e "\n------------------ rabbitmq server started ------------------"
service rabbitmq-server start
#echo -e "\n------------------ rabbitmq add user       ------------------"
if [[ -z $(rabbitmqctl list_users | grep tensormsa) ]]; then
  echo "rabbitmq Tensormsa add user" 
  rabbitmqctl add_user tensormsa tensormsa
  echo "rabbitmq Tensormsa set user"
  rabbitmqctl set_user_tags tensormsa administrator
  echo "rabbitmq Tensormsa set user"
  rabbitmqctl set_permissions -p / tensormsa '.*' '.*' '.*'
fi


/bin/bash
