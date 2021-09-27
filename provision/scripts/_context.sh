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
if [ -z $HOSTNAME ]; then
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

if [command -v cowsay &> /dev/null ] 
then
  cowsay $(< /home/vagrant/provision/.env.$HOSTNAME)  
fi

####################################
# Require linux jq command 
function save_bash_environment {

  if command -v jq &> /dev/null
  then  
    if [ ! -z $HOSTNAME ] 
    then
      # convert .env.$HOSTNAME.json to .env.$HOSTNAME
      # basicaly convert pre-existent root keys from json file to .env file
      jsonFile=${dd}/provision/.env.${HOSTNAME}.json
      envFile=${dd}/provision/.env.${HOSTNAME}
      envKeys= jq -r '. | keys[]  ' $jsonFile
      echo "********************************"
      echo "json file: ${jsonFile}"
      echo "env file: ${envFile}"
      echo "********************************"
      rm $envFile
      jq -c '. | keys[]' $jsonFile | while read i; do
          echo $(echo ${i} | tr -d '"')=$(jq -r ".${i}" $jsonFile ) >> $envFile
      done

      if command -v cowsay &> /dev/null
      then
        cowsay " $file Created"
      fi
    else
      echo "Enable do save node .env file. HOSTNAME=|Missing|."
    fi
  else
    echo "Enable do generate node .env file. Linux jq command missing."
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
  file=$1
  if [ ! -f $file.backup ]; then
    sudo cp $file $file.backup
  else
    sudo cp $file.backup $file
  fi

}

function persist_env {
  VAR_KEY="$1"
  VAR_VALUE="$2"
  set_file_key_value /etc/environment "$VAR_KEY" "$VAR_VALUE"  
  export ${VAR_KEY}=${VAR_VALUE}
}

function set_file_key_value  {
  S_FILE="$1" 
  VAR_KEY="$2"
  VAR_VALUE="$3"
  tmp=$(mktemp)
  #delete prev pair key=value
  grep -v "$VAR_KEY=" "$S_FILE" > "$tmp" && sudo mv "$tmp" "$S_FILE"
  # set new DOCKER_HOST value
  echo "${VAR_KEY}=${VAR_VALUE}" | sudo tee -a "$S_FILE" 
}