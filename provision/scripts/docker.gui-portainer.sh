#
# dockerEasy2 provision
#
dd=/home/vagrant
. $dd/provision/scripts/_context.sh

node_info

## Install PORTAINER docker image
## setup PORTAINER docker container HOST_MAP_IP
## setup PORTAINER enviroment
cd $dd/provision/app/portainer

set_file_key_value .env HOST_MAP_IP ${VM_HOST_IP}
set_file_key_value .env HOST_MAP_PORT 8000
set_file_key_value .env DOCKER_HOST ${VM_DOCKER_HOST}

cowsay $(cat .env)

# pull portainer image
sudo docker pull portainer/portainer-ce
# if up then down
sudo docker-compose down
# finally up
sudo docker-compose up &
# wait for docker up
sleep 6
cd $dd
