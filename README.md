# Vagrant-docker

## Requirements
- *Computer to host vagrant-docker setup*
- [git](https://git-scm.com/downloads)
- [vagrant](https://www.vagrantup.com/downloads.html) - This project has been devepoled and tested with Vagrant >=2.2.10 .
- [virtualbox](https://www.virtualbox.org/wiki/Downloads)

## Provisions
- [Packer by HashiCorp](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli)
- [aws-cli](./AWS.md)


## Node default configuration
 dockerEasy2 setup in the <b> VagrantDockerSetup.rb </b> file
  ```shell
  # disable vagrant provision scripts
  IGNORE_PROVISION = false
  # Means that VM IPs will be VM_HOST_IP
  VM_HOST_IP = "192.168.3.100"  
  # In this case hostnames with be [vdocker]
  VM_HOST_NAME_PREFIX = "vdocker"
  # Image of OS used to on virtualbox
  VM_OS = "ubuntu/xenial64"
  # Docker version for install - For last version just set VM_DOCKER_VER empty
  VM_DOCKER_VER = "18.06.2~ce~3-0~ubuntu"
  # Change docker host
  VM_DOCKER_HOST = "-H fd:// -H tcp://#{VM_HOST_IP}:4243"
  # Change docker deamon args to enable TCPIP access
  VM_DOCKER_DAEMON_ARGS = "-H fd:// -H #{VM_DOCKER_HOST}"
  # Set VM_DNS_RESOLVER
  VM_DNS_RESOLVER = "8.8.8.8"
  # SSH-RSA OpenSSH to install on the node sshd service
  VM_SSH_ACCESS_KEY ="/home/vagrant/provision/your_key.pub"  
  # Memory used by the node
  VM_MEMORY = 1024
  # K8s requires at least 2 CPUs
  # CPUS used by the node
  VM_CPUS = 2
  # List of shared folder between HOST computer and the node
  VM_SYNC_FOLDERS = [
    ["d:/WWW","/www"]
  ]
  # List of forwarded ip/ports from VM to Host lookback adapter 127.0.0.1
  [vm ip to be forwarded, vm ip:port to be forwarded, host lookpback port to be forwarded to, service name
  VM_PORT_FORWARD = [  
  [VM_HOST_IP,4243,4243,"docker"], # docker
  [VM_HOST_IP,8000,8000,"portainer"], # portainer
#  [VM_HOST_IP,8080,8080],   # web-service http
  [VM_HOST_IP,8443,8443,"keycloak https"],   # keycloak https
  [VM_HOST_IP,7474,7474,"neo4j http"],   # neo4j
  [VM_HOST_IP,7687,7687,"neo4j bolt"],   # neo4j
  [VM_HOST_IP,9200,9200,"elastic search"],   # elastic search          
  [VM_HOST_IP,3306,3306,"mysql"],   # mysql
]
  ```
  ```

## Usage

1. Clone repo and change directory to dockerEasy2 directory
    ```shell
    $ git clone https://github.com/vitorcool/dockerEasy2
    $ cd dockerEasy2
    ```
    Setup dockerEasy2 by editing <b>Vagranfile</b> or not, and just use default configuration.

2. Run the Node
    ```shell
    # The first time you run the "vagrant up" command, it will take a long time.
    # So be patient.
    # If the host computer crashes, you try to reduce VM_MEMORY in the Vagrantfile
    $ vagrant up
    ```  

3. SSH Connect to node
    ```shell
    # Connect to node
    $ vagrant ssh    
    ```
4. Reboot
    ```shell
    #  Reboot node
    $ vagrant reload        
    ```

5. Destroy node
    ```shell
    $ vagrant destroy
    ```    


## Node Provision

### There are 3 Provision scripts:
||script | install phase
--- | --- | ---
|1|bootstrap | OS enviroment
|2|docker|Docker
|3|app| setup your enviroment. edit file scripts/app.sh


1. Install provison - can solve problems
```shell
# Provision bootstrap - 1st provision
$ vagrant up --provision-with bootstrap
```
```shell
# if bootstrap provision OK
# Provision docker - 2st provision
$ vagrant up --provision-with docker
$ vagrant up --provision-with docker.setup
```
```shell
# if provision kube OK
# Provision app - 3td provision
$ vagrant up --provision-with app
```
```shell

## Links
- [Docker](https://docs.docker.com/)


## After provision you might wont to:

# https://stackoverflow.com/questions/25758737/vagrant-login-as-root-by-default
```
sudo passwd root
```

# restart docker service 
```
 sudo systemctl restart docker
```
# re-install virtualbox guest ubuntu
```
sudo apt-get- updatede
sudo apt-get install virtual-guest-dkms -y
```
# sync time date between host and VM
```
# Check value do GetHostTimeDisabled
vboxmanage getextradata VMGDocker "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled"

# Set value to GetHostTimeDisabled
vboxmanage setextradata VMGDocker "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled" 0 
```