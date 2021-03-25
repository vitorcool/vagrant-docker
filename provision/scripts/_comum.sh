#
# dockerEasy2
#
if [ "${IGNORE_PROVISION}" == "true" ];then
  echo "IGNORE_PROVISION=$IGNORE_PROVISION"
  exit 1
fi

dd=/home/vagrant
# load node setup variables if they exist
envFile="$dd/provision/.env.$HOSTNAME"
if [ -z $NODE_NAME ]; then
  echo "Loading node setup variable into shell enviroment file:$envFile"
  if [ \ $envFile ];then
    . $envFile #loaded
    cowsay " $envFile Loaded OK"
  else
    cowsay " $envFile Load FAIL"
  fi
fi

####################################
function save_bash_environment {
  if [ ! -z $NODE_NAME ]; then
    cat > $envFile <<EOF
PATH=${dd}/provision/tools:\${PATH}
IGNORE_PROVISION='${IGNORE_PROVISION}'
NODE_IP='${NODE_IP}'
NODE_NAME='${NODE_NAME}'
VM_DNS_RESOLVER='${VM_DNS_RESOLVER}'
VM_SSH_ACCESS_KEY='${VM_SSH_ACCESS_KEY}'
VM_DOCKER_DAEMON_ARGS='${VM_DOCKER_DAEMON_ARGS}'
VM_DOCKER_VER='${VM_DOCKER_VER}'
VM_OS='${VM_OS}'
VM_MEMORY='${VM_MEMORY}'
VM_CPUS='${VM_CPUS}'
VM_SYNC_FOLDERS='${VM_SYNC_FOLDERS}'
EOF

    cowsay " $file Created"
  else
    echo "Enable do save node .env file. NODE_NAME=|Missing|."
  fi
}

function node_info {
  echo "--------------------------------------------------------------------------"
  echo "IGNORE_PROVISION: ${IGNORE_PROVISION}"
  echo "NODE_IP: ${NODE_IP}"
  echo "NODE_NAME: ${NODE_NAME}"  
  echo "USER: $(whoami)"
  echo "DIRECTORY: $(pwd)"
}

function backup_file_or_restore {
  $f=$1
  if [ ! -f $f.backup ]; then
    cp $f $f.backup
  else
    cp $f.backup $f
  fi

}
