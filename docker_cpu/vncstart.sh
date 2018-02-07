vncserver -kill :2 ; rm -rfv /tmp/.X*-lock /tmp/.X11-unix ;/usr/bin/vncserver -geometry 1920x1080 :2 \
  && tail -F $HOME/.vnc/*.log
