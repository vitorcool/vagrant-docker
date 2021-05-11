#
# dockerEasy2
#
dd=/home/vagrant
. $dd/provision/scripts/_context.sh
save_bash_environment

node_info
# install aws
apt-get  unzip  -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
chmod +x ./aws/install
sudo ./aws/install