# call "rabbitmqctl stop" when exiting
trap "{ echo Stopping rabbitmq; rabbitmqctl stop; exit 0; }" TERM

echo Starting rabbitmq
sudo rabbitmq-server &

# from docs: When Bash receives a signal for which a
# trap has been set while waiting for a command to
# complete, the trap will not be executed until the
# command completes.
# 
# This is why we use & and wait here. Idea taken from:
# http://veithen.github.io/2014/11/16/sigterm-propagation.html
PID=$!
wait $PID
