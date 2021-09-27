module VagrantDockerSetup
    IGNORE_PROVISION = false
    VM_HOST_IP = "192.168.215.10"
    VM_HOST_NAME = "VMG01"
    VM_DNS_RESOLVER = "8.8.8.8"
    # file SSH-RSA OpenSSH Format
    VM_SSH_ACCESS_KEY ="/home/vagrant/provision/public_key.pub"
    VM_DOCKER_HOST = "tcp://#{VM_HOST_IP}:4243"
    VM_DOCKER_DAEMON_ARGS = "-H fd:// -H #{VM_DOCKER_HOST}"
    #VM_DOCKER_VER = "18.06.2~ce~3-0~ubuntu"
    VM_DOCKER_VER = "17.03.0~ce-0~ubuntu-xenial"    
    VM_OS = "ubuntu/xenial64"
    VM_MEMORY = 3072 #3072
    # K8s requires at least 2 CPUs
    VM_CPUS = 2
    VM_SYNC_FOLDERS = [
        ["c:/galp","/c/galp"] 
    ]
    VM_PORT_FORWARD = [  
        [VM_HOST_IP,4243,4243,"docker"], # docker
        [VM_HOST_IP,8000,8000,"portainer"], # portainer
        #  [VM_HOST_IP,8080,8080],   # web-service http
        [VM_HOST_IP,8443,8443,"keycloak https"],   # keycloak https
        [VM_HOST_IP,5000,5000,"amundsen frontend http"],   # amundsen frontend http
        [VM_HOST_IP,5001,5001,"amundsen metadata http"],   # amundsen metadata http
        [VM_HOST_IP,5002,5002,"amundsen search http"],   # amundsen search http
        [VM_HOST_IP,4000,4000,"sbx amundsen frontend http"],   # sbx amundsen frontend http
        [VM_HOST_IP,4001,4001,"sbx amundsen metadata http"],   # sbx amundsen metadata http
        [VM_HOST_IP,4002,4002,"sbx amundsen search http"],   # sbx amundsen search http
        [VM_HOST_IP,7474,7474,"neo4j http"],   # neo4j
        [VM_HOST_IP,7687,7687,"neo4j bolt"],   # neo4j
        [VM_HOST_IP,9200,9200,"elastic search"],   # elastic search          
        [VM_HOST_IP,3306,3306,"mysql"],   # mysql
    ]

end