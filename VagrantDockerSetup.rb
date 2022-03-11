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
    VM_MEMORY = 5096
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
        [VM_HOST_IP,8000,8000,"portainer"], # portainer

        [VM_HOST_IP,3001,3001,"nodejs http service1"],   # nodejs http service1
        [VM_HOST_IP,3002,3002,"nodejs http service2"], # nodejs http service2
        [VM_HOST_IP,3003,3003,"nodejs http service3"], # nodejs http service3
        [VM_HOST_IP,3004,3004,"nodejs http service4"], # nodejs http service4
        [VM_HOST_IP,3306,3306,"mysql"],   # mysql
        [VM_HOST_IP,8080,8080,"keycloak http"],   # keycloak2 http
        [VM_HOST_IP,8443,8443,"keycloak https"],  # keycloak https
        [VM_HOST_IP,5000,5000,"amundsen frontend http"],   # amundsen frontend http
        [VM_HOST_IP,5443,5443,"amundsen frontend https"],   # amundsen frontend 
        [VM_HOST_IP,5001,5001,"amundsen metadata http"],   # amundsen metadata http
        [VM_HOST_IP,5002,5002,"amundsen search http"],   # amundsen search http
        [VM_HOST_IP,7474,7474,"neo4j http"],   # neo4j
        [VM_HOST_IP,7687,7687,"neo4j bolt"],   # neo4j
        [VM_HOST_IP,9200,9200,"elastic search"],   # elastic search      

        [VM_HOST_IP,5010,5010,"amundsen frontend http v2"],   # amundsen frontend http
        [VM_HOST_IP,5453,5453,"amundsen frontend https v2"],   # amundsen frontend 
        [VM_HOST_IP,5011,5011,"amundsen metadata http v2"],   # amundsen metadata http
        [VM_HOST_IP,5012,5012,"amundsen search http v2"],   # amundsen search http
        [VM_HOST_IP,7475,7475,"neo4j http v2"],   # neo4j
        [VM_HOST_IP,7688,7688,"neo4j bolt v2"],   # neo4j
        [VM_HOST_IP,9201,9201,"elastic search v2"],   # elastic search      

        [VM_HOST_IP,5672,5672,"RabbitMQ client connections"],   # RabbitMQ client connections        
        [VM_HOST_IP,15672,15672,"RabbitMQ management website"], # RabbitMQ management website          
######## kubectl portforward sbx services [es,neo4j]                
        [VM_HOST_IP,17474,17474,"SBX neo4j http"],   # neo4j
        [VM_HOST_IP,17687,17687,"SBX neo4j bolt"],   # neo4j
        [VM_HOST_IP,19200,19200,"SBX elastic search"],   # elastic search          
######## kubectl portforward sbx services [keycloak]   
        [VM_HOST_IP,18443,18443,"SBX keycloak IDP https"],  # keycloak2 https - identity provider
        [VM_HOST_IP,18080,18080,"SBX keycloak IDP http"],   # keycloak2 http - identity provider
        [VM_HOST_IP,15432,15432,"SBX PostgreSQl as keycloak Storage"],   # SBX PostgreSQl as keycloak Storage
######## kubectl portforward sbx services ulysses:[fe,search,metadata]
        [VM_HOST_IP,15000,15000,"sbx amundsen frontend http"],   # sbx amundsen frontend http
        [VM_HOST_IP,15001,15001,"sbx amundsen metadata http"],   # sbx amundsen metadata http
        [VM_HOST_IP,15002,15002,"sbx amundsen search http"],   # sbx amundsen search http
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