# sync date time
#timedatectl set-timezone Europe/Lisbon
timedatectl set-timezone Etc/GMT
timedatectl set-ntp on

sudo apt-get install -y ntp
sudo service ntp restart
ntpq -p
date

