#
# dockerEasy2
#
dd=/home/vagrant
. $dd/provision/scripts/_context.sh
save_bash_environment

node_info




### Install packages to allow apt to use a repository over HTTPS
apt-get update && apt-get install apt-transport-https ca-certificates curl software-properties-common -y

### Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

### Add Docker apt repository.
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

apt-get update 
apt-cache policy docker-ce
## Install Docker CE.
if [ -z ${VM_DOCKER_VER} ]; then
  apt-get install docker-ce -y
else
  apt-get install docker-ce=${VM_DOCKER_VER} -y  --allow-downgrades
fi
apt-get install docker-ce-cli docker-compose -y

