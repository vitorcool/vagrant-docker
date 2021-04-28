IGNORE_PROVISION = false
NODE_IP = "192.168.215.10"
NODE_NAME = "VMGDocker"
VM_DNS_RESOLVER = "8.8.8.8"
# file SSH-RSA OpenSSH Format
VM_SSH_ACCESS_KEY ="/home/vagrant/provision/public_key.pub"
VM_DOCKER_HOST = "tcp://#{NODE_IP}:4243"
VM_DOCKER_DAEMON_ARGS = "-H fd:// -H #{VM_DOCKER_HOST}"
#VM_DOCKER_VER = "18.06.2~ce~3-0~ubuntu"
VM_DOCKER_VER = ""
VM_OS = "ubuntu/xenial64"
VM_MEMORY = 3072 #3072
# K8s requires at least 2 CPUs
VM_CPUS = 2
VM_SYNC_FOLDERS = [
  ["c:/galp","/c/galp"]
]
VM_PORT_FORWARD = [
  [NODE_IP,4243,4243,"docker"], # docker
  [NODE_IP,8000,8000,"portainer"], # portainer
#  [NODE_IP,8080,8080],   # web-service http
  [NODE_IP,8443,8443,"keycloak https"],   # keycloak https
  [NODE_IP,5000,5000,"amundsen fe http"],   # amundsen http
  [NODE_IP,7474,7474,"neo4j http"],   # neo4j
  [NODE_IP,7687,7687,"neo4j bolt"],   # neo4j
  [NODE_IP,9200,9200,"elastic search"],   # elastic search          
]


def node_provision_args()
  {
    "IGNORE_PROVISION" => "#{IGNORE_PROVISION}",
    "NODE_IP" => "#{NODE_IP}",
    "NODE_NAME" => "#{NODE_NAME}",
    "VM_DNS_RESOLVER" => "#{VM_DNS_RESOLVER}",
    "VM_SSH_ACCESS_KEY" => "#{VM_SSH_ACCESS_KEY}",
    "VM_DOCKER_HOST" => "#{VM_DOCKER_HOST}",
    "VM_DOCKER_DAEMON_ARGS" => "#{VM_DOCKER_DAEMON_ARGS}",
    "VM_DOCKER_VER" => "#{VM_DOCKER_VER}",
    "VM_OS" => "#{VM_OS}",
    "VM_MEMORY" => "#{VM_MEMORY}",
    "VM_CPUS" => "#{VM_CPUS}",
    "VM_SYNC_FOLDERS" => "#{VM_SYNC_FOLDERS}"
  }
end

Vagrant.configure("2") do |config|

  # Xenial is a bit old but works best at the moment. Kubectl repo seems to bedash
  # Xenial is a bit old but works best at the moment. Kubectl repo seems to be
  # available for Xenial only currently
  config.vm.box = VM_OS
  # Sync time with the local host
  config.vm.provider 'virtualbox' do |vb|
   vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
   vb.memory = VM_MEMORY
   vb.cpus = "#{VM_CPUS}"
  end
  # Change the provision to match your environment
  config.vm.synced_folder "./provision", "/home/vagrant/provision"
  for index in 0 ... VM_SYNC_FOLDERS.size
    folder = VM_SYNC_FOLDERS[index]
    config.vm.synced_folder folder[0], folder[1]
  end


  config.vm.define "#{NODE_NAME}" do |node|

    name = "#{NODE_NAME}"
    ip = "#{NODE_IP}"

    node.vm.hostname  = name
    node.vm.network "private_network", ip: ip
    node.vm.provider "virtualbox" do |vb|
      vb.name = name
    end

    for index in 0 ... VM_PORT_FORWARD.size
      port_forward = VM_PORT_FORWARD[index]
      config.vm.network "forwarded_port", guest_ip: port_forward[0], guest: port_forward[1], host: port_forward[2],id: port_forward[3]
    end

    NODE_NAME = name
    NODE_IP = ip

    node.vm.provision "bootstrap", type: "shell", path: "provision/scripts/bootstrap.sh", env: node_provision_args(), run: "runonce"
    node.vm.provision "docker",      type: "shell", path: "provision/scripts/docker.sh",    env: node_provision_args(), run: "runonce"
    node.vm.provision "app",      type: "shell", path: "provision/scripts/app.sh",        env: node_provision_args()

  end
  
end
