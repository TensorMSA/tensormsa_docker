vncserver -kill ${VNC_PORT} ; rm -rfv /tmp/.X*-lock /tmp/.X11-unix ;/usr/bin/vncserver -geometry ${VNC_RESOLUTION} ${VNC_PORT} \
  && tail -F $HOME/.vnc/*.log
