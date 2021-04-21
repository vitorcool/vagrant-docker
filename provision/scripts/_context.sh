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
    if command -v cowsay &> /dev/null
    then
      cowsay " $envFile Loaded OK"
    fi
  else
    if command -v cowsay &> /dev/null
    then
      cowsay " $envFile Load FAIL"
    fi
  fi
fi

if command -v cowsay &> /dev/null
then
  cowsay $(< /home/vagrant/provision/.env.$HOSTNAME)  
fi

####################################
function save_bash_environment {
  if [ ! -z $NODE_NAME ]; then
    cat > $envFile <<EOF
PATH=${dd}/provision/scripts:\${PATH}
IGNORE_PROVISION='${IGNORE_PROVISION}'
NODE_IP='${NODE_IP}'
NODE_NAME='${NODE_NAME}'
VM_DNS_RESOLVER='${VM_DNS_RESOLVER}'
VM_SSH_ACCESS_KEY='${VM_SSH_ACCESS_KEY}'
VM_DOCKER_HOST='${VM_DOCKER_HOST}'
VM_DOCKER_DAEMON_ARGS='${VM_DOCKER_DAEMON_ARGS}'
VM_DOCKER_VER='${VM_DOCKER_VER}'
VM_OS='${VM_OS}'
VM_MEMORY='${VM_MEMORY}'
VM_CPUS='${VM_CPUS}'
VM_SYNC_FOLDERS='${VM_SYNC_FOLDERS}'
EOF
    if command -v cowsay &> /dev/null
    then
      cowsay " $file Created"
    fi
  else
    echo "Enable do save node .env file. NODE_NAME=|Missing|."
  fi
}

function node_info {
  echo "--------------------------------------------------------------------------"
  echo "USER: $(whoami)"
  echo "DIRECTORY: $(pwd)"
  if command -v cowsay &> /dev/null
  then
    cowsay $(< /home/vagrant/provision/.env.$HOSTNAME)  
  fi  
}

function backup_file_or_restore {
  $f=$1
  if [ ! -f $f.backup ]; then
    cp $f $f.backup
  else
    cp $f.backup $f
  fi

}

function persist_env {
  VAR_KEY="$1"
  VAR_VALUE="$2"
  set_file_key_value /etc/enviroment "$VAR_KEY" "$VAR_VALUE"  
  export ${VAR_KEY}=${VAR_VALUE}
}

function set_file_key_value  {
  S_FILE="$1" #/etc/enviroment
  VAR_KEY="$2"
  VAR_VALUE="$3"
  tmp=$(mktemp)
  #delete prev pair key=value
  grep -v "$VAR_KEY=" "$S_FILE" > "$tmp" && sudo mv "$tmp" "$S_FILE"
  # set new DOCKER_HOST value
  echo "${VAR_KEY}=${VAR_VALUE}" | sudo tee -a "$S_FILE" 
}