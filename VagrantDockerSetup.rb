module VagrantDockerSetup
    IGNORE_PROVISION = false    
    #VM_HOST_IP = "192.168.1.10" - disabled
    VM_HOST_IP = "192.168.215.10"
    VM_HOST_NAME = "VMGalp"
    # disabled 4 now: VM_GATEWAY_IP = "192.168.1.254"
    VM_DNS_RESOLVER = "8.8.8.8"
    # file SSH-RSA OpenSSH Format
    VM_SSH_ACCESS_KEY ="/home/vagrant/provision/public_key.pub"
    VM_DOCKER_HOST = "tcp://#{VM_HOST_IP}:4243"
    VM_DOCKER_DAEMON_ARGS = "-H fd:// -H #{VM_DOCKER_HOST}"
    #VM_DOCKER_VER = "18.06.2~ce~3-0~ubuntu"
    VM_DOCKER_VER = "17.03.0~ce-0~ubuntu-xenial"    
    VM_OS = "ubuntu/xenial64"
    VM_MEMORY = 4072
    # K8s requires at least 2 CPUs
    VM_CPUS = 2
    VM_SYNC_FOLDERS = [
        ["c:/galp","/c/galp"] 
    ]

    # TCP ports forwared from VM_HOST_IP to HOST 127.0.0.1 
    VM_PORT_FORWARD = [  
        [VM_HOST_IP,80,80,"nginx http"], # http
        [VM_HOST_IP,443,443,"nginx https"], # https        
        [VM_HOST_IP,4243,4243,"docker"], # docker
        [VM_HOST_IP,6000,6000,"debug server"], # debug server
        [VM_HOST_IP,8000,8000,"portainer"], # portainer
        [VM_HOST_IP,3000,3000,"keycloak ulysses:client1:vpn"],   # keycloak2 ulysses:client1:vpn
        [VM_HOST_IP,3001,3001,"keycloak ulysses:client1:public"], # keycloak2 ulysses:client1:public
        [VM_HOST_IP,8080,8080,"keycloak http"],   # keycloak2 http
        [VM_HOST_IP,8443,8443,"keycloak https"],  # keycloak https
        [VM_HOST_IP,8787,8787,"keycloak debug"],   # keycloak2 debug
        [VM_HOST_IP,9443,9443,"keycloak IDP https"],  # keycloak2 https - identity provider
        [VM_HOST_IP,9080,9080,"keycloak IDP http"],   # keycloak2 http - identity provider
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

    # Will provision VagrantDocker with foreach VM_PROVISION scriptName /provision/scripts/{scriptName}.sh 
    VM_PROVISION = [
        "bootstrap",
        "syncdate",
        "python3.9",
        "docker",
        "docker.setup", 
        "docker.gui-portainer",
        "packer", 
        "aws", 
        "kubectl", 
        "nodejs"
    ]

end