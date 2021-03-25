#
# dockerEasy2
#
dd=/home/vagrant
. $dd/provision/scripts/_comum.sh
node_info

echo "------------------------------------------------------- Installing cowsay"
apt-get update
apt-get install cowsay -y
cp /usr/games/cowsay /usr/bin

echo "----------------------------------------------- store .env.$HOSTNAME file"
# create .env.$HOSTNAME file
save_bash_environment

echo "------------------------------------------------------------- Disable swap"
swapoff -a
sed -i '/swap/s/^/#/' /etc/fstab

echo "---------------------------------------------------Install SSH Custom keys"
cat ${VM_SSH_ACCESS_KEY} >> /home/vagrant/.ssh/authorized_keys
systemctl restart sshd

echo "-------------------------------------------------------- Update hosts file"
f="/etc/hosts"
backup_file_or_restore $f

hostNAME="${NODE_NAME}"  
hostIP="${NODE_IP}"
echo "$hostIP $hostNAME" >> /etc/hosts

cowsay $(cat /etc/hosts)

echo "------------------------------------------------------ Update DNS Resolver to: ${VM_DNS_RESOLVER}"
echo "nameserver ${VM_DNS_RESOLVER}">/etc/resolv.conf
cowsay $(cat /etc/resolv.conf)
