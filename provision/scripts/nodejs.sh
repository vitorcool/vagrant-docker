#
# dockerEasy2 provision Template
#
dd=/home/vagrant
. $dd/provision/scripts/_context.sh
node_info

persist_env NVM_DIR /usr/local/nvm
persist_env NODE_VERSION 14.15.4
sudo curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# add nvm,nodejs,npm resolution to current .profile script
echo "source /usr/local/nvm/nvm.sh" >> .profile
source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# install concurrently and sass nodejs packages
source $NVM_DIR/nvm.sh \
	&& npm install concurrently sass -g 





