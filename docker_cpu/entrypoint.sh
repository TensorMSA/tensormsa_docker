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
  #echo "Starting ssh demon"
  #service ssh start 

  echo "Starting PostgreSQL ${PG_VERSION}..."
  exec start-stop-daemon --start --chuid ${PG_USER}:${PG_USER} \
    --exec ${PG_BINDIR}/postgres -- -D ${PG_DATADIR} ${EXTRA_ARGS}&

else
  exec "$@"
fi

##change vnc password
echo "change vnc password!"
(echo $VNC_PW && echo $VNC_PW) | vncpasswd

service dbus start
supervisord -n &
#sleep 3 

#if [[ -z $(rabbitmqctl list_users | grep tensormsa) ]]; then
#  echo "rabbitmq Tensormsa add user"
#  rabbitmqctl add_user tensormsa tensormsa
#  echo "rabbitmq Tensormsa set user"
#  rabbitmqctl set_user_tags tensormsa administrator
#  echo "rabbitmq Tensormsa set user"
#  rabbitmqctl set_permissions -p / tensormsa '.*' '.*' '.*'
#fi



/bin/bash
