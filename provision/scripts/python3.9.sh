#
# dockerEasy2
#
dd=/home/vagrant
. $dd/provision/scripts/_context.sh
save_bash_environment

node_info


apt-get update && apt-install install software-properties-common

#The PPA you'll need to add is maintained by "deadsnakes", so let's add that:
sudo add-apt-repository ppa:deadsnakes/ppa -y

apt-get update update && apt-get install python3.9

python3.9 --version 

