# Vagrant-docker install-flow-windows-10

- ## First define development folder. This is the root folder where is your docker projects
```
md c:\projects
```

- ## Pull vagrant-docker 
## @windows console execute
```
md vagrant-docker

# clone repository
git clone https://github.com/vitorcool/vagrant-docker.git

# change to created folder
cd vagrant-docker
```
### This will be the first projec on c:\galp
### Now, and before start building default VMDocker virtual machine, check Vagrantfile variables
### Use any text editor:
 
- ## To set Vagrantfile VM_SYNC_FOLDERS variable with your choice for development folder
```
VM_SYNC_FOLDERS = [
  ["D:/galp","/galp"]
]
```
### This definition will mount the defined "virtual machine host" folder insize "virtual machine".
### If any file or directory change in the host folder "D:/galp" it will afect "/galp" folder in the virtual machine
[You can check other Vagrantfile variables](./README.md)

- ### Build your virtual machine
```
vagrant up
```
### Wait some minutes depending on computer speed. Be pacient and after up process finishes

- ### Setup docker CLI and docker-compose CLI on host machine
```
# install docker cli 
choco install docker-cli

# install docker-compose CLI 
choco install docker-compose

#set enviroment 
# set host docker cli to connect VM Docker service
set DOCKER_HOST=192.168.3.10:4243

# avoid conflits between windows and linux file paths
set COMPOSE_CONVERT_WINDOWS_PATHS=1
```
# fix erro on "vagrant ssh" command resulting on : vagrant@127.0.0.1: Permission denied (publickey).
set VAGRANT_PREFER_SYSTEM_BIN=0

- ### Install and Run docker projects on your development folder
```
cd c:\projects
git clone someProject
cd someProject
docker-compose up
``´