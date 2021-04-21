#
# dockerEasy2 provision
#
dd=/home/vagrant
. $dd/provision/scripts/_context.sh

node_info

## Install PORTAINER docker image
## setup PORTAINER docker container HOST_MAP_IP
## setup PORTAINER enviroment
cd $dd/provision/app/keycloak

set_file_key_value .env HOST_MAP_IP 192.168.3.10
#set_file_key_value .env HOST_NAME 192.168.3.10

cowsay $(cat .env)

# pull image
sudo docker pull jboss/keycloak:12.0.4
# if up then down
sudo docker-compose down
# finally up
sudo docker-compose up &
# wait for docker up
sleep 6s
cd $dd
