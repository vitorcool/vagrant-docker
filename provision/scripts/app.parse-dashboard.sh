#
# dockerEasy2 provision 
#
dd=/home/vagrant
. $dd/provision/scripts/_comum.sh
node_info


# get PARSE_DASHBOARD project, BUILD DOCKER IMAGE
#cd $dd/provision/app
# git clone || git push
#if cd parse-dashboard; then git pull; else git clone https://github.com/parse-community/parse-dashboard.git; fi
#cd $dd/provision/app/parse-dashboard
#sudo docker build --tag parse-dashboard .

sudo docker login
sudo docker pull parseplatform/parse-dashboard

## Install PARSE_DASHBOARD docker image
## setup PARSE_DASHBOARD docker container HOST_MAP_IP
## setup PARSE_DASHBOARD enviroment
cd $dd/provision/app/parse/dashboard

echo "HOST_MAP_IP=${NODE_IP}" > .env
echo "HOST_MAP_PORT=8080" >> .env

echo "PARSE_DASHBOARD_ALLOW_INSECURE_HTTP=true" >> .env

sudo docker-compose down
sudo docker-compose up &
cd $dd