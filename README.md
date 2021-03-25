# Vagrant-docker

## Requirements
- *Computer to host cloud setup*
- [git](https://git-scm.com/downloads)
- [vagrant](https://www.vagrantup.com/downloads.html) - This project has been devepoled and tested with Vagrant >=2.2.10 .
- [virtualbox](https://www.virtualbox.org/wiki/Downloads)


## Node default configuration
 dockerEasy2 setup the cluster in the <b> Vagrantfile </b> file
  ```shell
  # disable vagrant provision scripts
  IGNORE_PROVISION = false
  # Means that VM IPs will be NODE_IP
  NODE_IP = "192.168.3.100"  
  # In this case hostnames with be [vdocker]
  NODE_NAME_PREFIX = "vdocker"
  # Image of OS used to on virtualbox
  VM_OS = "ubuntu/xenial64"
  # Docker version for install - For last version just set VM_DOCKER_VER empty
  VM_DOCKER_VER = "18.06.2~ce~3-0~ubuntu"
  # Change docker deamon args to enable TCPIP access
  VM_DOCKER_DAEMON_ARGS = "-H fd:// -H tcp://#{CLUSTER_IP_PREFIX}.#{CLUSTER_NODE_IP_LESS_START}:4243"
  # Set VM_DNS_RESOLVER
  VM_DNS_RESOLVER = "8.8.8.8"
  # SSH-RSA OpenSSH to install on the node sshd service
  VM_SSH_ACCESS_KEY ="/home/vagrant/provision/vitor_public_key.pub"  
  # Memory used by the node
  VM_MEMORY = 3072
  # K8s requires at least 2 CPUs
  # CPUS used by the node
  VM_CPUS = 2
  # List of shared folder between HOST computer and the node
  VM_SYNC_FOLDERS = [
    ["d:/WWW","/www"]
  ]
  ```

## Usage

1. Clone repo and change directory to dockerEasy2 directory
    ```shell
    $ git clone https://github.com/vitorcool/dockerEasy2
    $ cd dockerEasy2
    ```
    Now is time to setup dockerEasy2 by editing <b>Vagranfile</b> or not, and just use de cluster default configuration.

2. Run the Node
    ```shell
    # The first time you run the "vagrant up" command, it will take a long time.
    # So be patient.
    # If the host computer crashes, you try to reduce VM_MEMORY in the cluster configuration  
    $ vagrant up
    ```  

3. SSH Connect to node
    ```shell
    # Connect to node
    $ vagrant ssh    
    ```
5. Reboot
    ```shell
    #  Reboot node
    $ vagrant reload        
    ```

6. Destroy node
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
sudo passwd root

# restart docker service 
 sudo systemctl start docker
