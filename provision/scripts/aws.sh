#
# dockerEasy2
#
# install aws
#
apt-get update && apt-get install unzip  -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
chmod +x ./aws/install
./aws/install