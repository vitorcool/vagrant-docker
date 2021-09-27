#
# dockerEasy2
#
# Install and setup docker service according to VM_* predefined values
# values:
#   - VM_DOCKER_VER
#   - VM_DOCKER_DAEMON_ARGS
#   - VM_DOCKER_HOST
#
dd=/home/vagrant
. $dd/provision/scripts/_context.sh
save_bash_environment

node_info

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
systemctl daemon-reload
systemctl restart docker
read -p "Pause Time 5 seconds" -t 5

#todo - add -H tcp://${VM_HOST_IP}:4243 to /var/systemd/system/docker.service
# daemon_args=${VM_DOCKER_DAEMON_ARGS}
function replace_docker_daemon_args {
  daemon_args="$1"
  S_FILE=/lib/systemd/system/docker.service
  backup_file_or_restore $S_FILE

  S_SEARCH=$(cat $S_FILE | grep  ^ExecStart=)
  S_CMD=$(cat $S_FILE | awk "/ExecStart=/"'{print $1}')
  S_REPLACE="${S_CMD} ${daemon_args}"
  echo "file:$S_FILE";echo "search:$S_SEARCH";echo "cmd:$S_CMD";echo "args:$daemon_args"
  sed -i "s|$S_SEARCH|$S_REPLACE|" $S_FILE
  cat $S_FILE | grep  ^ExecStart=
}
replace_docker_daemon_args "${VM_DOCKER_DAEMON_ARGS}"

# store DOCKER_HOST=
persist_env DOCKER_HOST ${VM_DOCKER_HOST} 

# Restart docker.
systemctl daemon-reload
systemctl restart docker

# Enable packet forwarding
sysctl net.bridge.bridge-nf-call-iptables=1
