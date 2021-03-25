#
# dockerEasy2 provision 
#
dd=/home/vagrant
. $dd/provision/scripts/_comum.sh
node_info

# get PARSE_SERVER project, BUILD DOCKER IMAGE
# git clone || git push
cd $dd/provision/app
if cd parse-server;then git pull; else git clone https://github.com/parse-community/parse-server;npm install --save parse-server-generic-email-adapter; fi
cd $dd/provision/app/parse-server
sudo docker build --tag parse-server .

#sudo docker login
#sudo docker pull parseplatform/parse-server


## Install PARSE_SERVER docker image
## setup PARSE_SERVER docker container HOST_MAP_IP
## setup PARSE_SERVER enviroment
cd $dd/provision/app/parse/server

#server options
echo "HOST_MAP_IP=${NODE_IP}" > $dd/provision/app/parse/server/.env
echo "HOST_MAP_PORT=1337" >> .env

sudo docker-compose down
sudo docker-compose up &
cd $dd


exit

echo "PARSE_SERVER_CLUSTER=true" >> .env
echo "PARSE_SERVER_DATABASE_URI=mongodb://mongo:qwe123@192.168.3.100:27017" >> .env
echo "PARSE_SERVER_HOST=127.0.0.1" >> .env
echo "PARSE_SERVER_ALLOW_ORIGIN=*" >> .env
echo "PARSE_SERVER_ENABLE_ANON_USERS=false" >> .env
echo "PARSE_SERVER_MOUNT_GRAPHQL=true" >> .env
# 30 days
echo "PARSE_SERVER_SESSION_LENGTH=2592000" >> .env
# email verifiication
#echo "PARSE_SERVER_VERIFY_USER_EMAILS=true" >> .env
#echo "PARSE_SERVER_EMAIL_ADAPTER=true" >> .env

# dev options to disable on production server
echo "PARSE_SERVER_SECURITY_ENABLE_CHECK_LOG=true" >> .env

#app options
echo "PARSE_SERVER_APPLICATION_ID=MY_APPLICATION_ID" >> .env
echo "PARSE_SERVER_APP_NAME=MY_APPLICATION_NAME" >> .env
echo "PARSE_SERVER_MASTER_KEY=MY_MASTER_KEY" >> .env
echo "PARSE_SERVER_JAVASCRIPT_KEY=MY_JAVASCRIPT_KEY" >> .env
echo "PARSE_SERVER_WEBHOOK_KEY=MY_WEBHOOK_KEY" >> .env

