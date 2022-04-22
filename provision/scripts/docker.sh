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
apt-get install docker-ce-cli -y

## docker-compose
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
VERSION=1.29.2
DESTINATION=/usr/bin/docker-compose # for every user
#DESTINATION=/usr/local/bin/docker-compose # only for root/su
rm $DESTINATION
curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
chmod +x $DESTINATION
chmod 755 $DESTINATION

## krew
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew

  echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> .bashrc
)