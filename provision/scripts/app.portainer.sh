#
# dockerEasy2 provision
#
dd=/home/vagrant
. $dd/provision/scripts/_comum.sh
node_info

## Install PORTAINER docker image
## setup PORTAINER docker container HOST_MAP_IP
## setup PORTAINER enviroment
cd $dd/provision/app/portainer

echo "HOST_MAP_IP=${NODE_IP}" > .env
echo "HOST_MAP_PORT=8000" >> .env

sudo docker-compose down
sudo docker-compose up &
cd $dd
