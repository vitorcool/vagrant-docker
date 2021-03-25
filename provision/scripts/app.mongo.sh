#
# dockerEasy2 provision 
#
dd=/home/vagrant
. $dd/provision/scripts/_comum.sh
node_info


## Install MONGO docker image
## setup MONGO docker container HOST_MAP_IP
## setup MONGO enviroment
cd $dd/provision/app/mongo

echo "HOST_MAP_IP=${NODE_IP}" > .env
echo "HOST_MAP_PORT=8081" >> .env
echo "MONGO_USERNAME=mongo" >> .env
echo "MONGO_PASSWORD=qwe123" >> .env
    
sudo docker-compose down
sudo docker-compose up &
cd $dd
