#
# dockerEasy2 provision Template
#
dd=/home/vagrant
. $dd/provision/scripts/_comum.sh
node_info

# install nodejs, npm, nvm
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o install_nvm.sh
sudo chmod +x install_nvm.sh 
./install_nvm.sh 
source ./.profile
nvm install v14.15.4
nvm alias default v14.15.4
nvm use default

$dd/provision/scripts/app.portainer.sh
