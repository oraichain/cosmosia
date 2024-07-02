# usage: ./run.sh chain_name
# eg., ./run.sh cosmoshub

# functions
loop_forever () {
  echo "loop forever for debugging only"
  while true; do sleep 5; done
}

echo "#################################################################################################################"

########################################################################################################################
# get binary
curl -L https://github.com/cosmos/relayer/releases/download/v2.5.2/Cosmos.Relayer_2.5.2_linux_amd64.tar.gz | tar -xz --strip-components=1 -C /go/bin

########################################################################################################################
# supervised
pacman -Sy --noconfirm supervisor
mkdir -p /etc/supervisor.d
echo_supervisord_conf > /etc/supervisord.conf
echo "[include]
files = /etc/supervisor.d/*.conf" >> /etc/supervisord.conf

cat <<EOT > /etc/supervisor.d/chain.conf
[program:chain]
command=/bin/bash /root/start_chain.sh
autostart=false
autorestart=false
stopasgroup=true
killasgroup=true
stderr_logfile=/var/log/chain.err.log
stdout_logfile=/var/log/chain.out.log
EOT

supervisord

# start_chain.sh script
cat <<EOT >> $HOME/start_chain.sh
source $HOME/env.sh
# fix supervisorctl creates a dbus-daemon process everytime starting chain
killall dbus-daemon
#$HOME/go/bin/$daemon_name start $start_flags 1>&2
/go/bin/rly start 1>&2
EOT

echo "#################################################################################################################"
echo "start chain..."
supervisorctl start chain

loop_forever
