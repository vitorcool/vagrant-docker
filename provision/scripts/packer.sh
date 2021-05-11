#
# dockerEasy2
#
dd=/home/vagrant
. $dd/provision/scripts/_context.sh
save_bash_environment

node_info


# install packer
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get install packer -y

