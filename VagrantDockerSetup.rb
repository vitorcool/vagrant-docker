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
    VM_MEMORY = 4096
    # K8s requires at least 2 CPUs
    VM_CPUS = 2
    VM_SYNC_FOLDERS = [
        ["c:/galp","/c/galp"] 
    ]

    # TCP ports forwared from VM_HOST_IP to HOST 127.0.0.1 
    VM_PORT_FORWARD_HOST_IP = '127.0.0.1'
    VM_PORT_FORWARD = [          
#        [VM_HOST_IP,80,80,"nginx http"], # http
#        [VM_HOST_IP,443,443,"nginx https"], # https        
        [VM_HOST_IP,4243,4243,"docker"], # docker
        [VM_HOST_IP,8000,8000,"portainer"], # portainer

        [VM_HOST_IP,3001,3001,"nodejs http service01"],   # nodejs http service1
        [VM_HOST_IP,3002,3002,"nodejs http service02"], # nodejs http service2
        [VM_HOST_IP,3003,3003,"nodejs http service03"], # nodejs http service3
        [VM_HOST_IP,3004,3004,"nodejs http service04"], # nodejs http service4
        [VM_HOST_IP,3005,3005,"nodejs http service05"],   # nodejs http service1
        [VM_HOST_IP,3006,3006,"nodejs http service06"], # nodejs http service2
        [VM_HOST_IP,3007,3007,"nodejs http service07"], # nodejs http service3
        [VM_HOST_IP,3008,3008,"nodejs http service08"], # nodejs http service4
        [VM_HOST_IP,3101,3101,"nodejs http service11"],   # nodejs http service1
        [VM_HOST_IP,3102,3102,"nodejs http service12"], # nodejs http service2
        [VM_HOST_IP,3103,3103,"nodejs http service13"], # nodejs http service3
        [VM_HOST_IP,3104,3104,"nodejs http service14"], # nodejs http service4
        [VM_HOST_IP,3105,3105,"nodejs http service15"],   # nodejs http service1
        [VM_HOST_IP,3106,3106,"nodejs http service16"], # nodejs http service2
        [VM_HOST_IP,3107,3107,"nodejs http service17"], # nodejs http service3
        [VM_HOST_IP,3108,3108,"nodejs http service18"], # nodejs http service4

        [VM_HOST_IP,2001,2001,"nodejs http service91"],   # nodejs http service1
        [VM_HOST_IP,2002,2002,"nodejs http service92"], # nodejs http service2
        [VM_HOST_IP,2003,2003,"nodejs http service93"], # nodejs http service3
        [VM_HOST_IP,2004,2004,"nodejs http service94"], # nodejs http service4
        [VM_HOST_IP,2005,2005,"nodejs http service95"],   # nodejs http service1
        [VM_HOST_IP,2006,2006,"nodejs http service96"], # nodejs http service2
        [VM_HOST_IP,2007,2007,"nodejs http service97"], # nodejs http service3
        [VM_HOST_IP,2008,2008,"nodejs http service98"], # nodejs http service4

        [VM_HOST_IP,3306,3306,"mysql"],   # mysql
   #     [VM_HOST_IP,8080,8080,"keycloak http"],   # keycloak2 http
   #     [VM_HOST_IP,8443,8443,"keycloak https"],  # keycloak https
        [VM_HOST_IP,5000,5000,"amundsen frontend http"],   # amundsen frontend http
        [VM_HOST_IP,5443,5443,"amundsen frontend https"],   # amundsen frontend 
        [VM_HOST_IP,5001,5001,"amundsen metadata http"],   # amundsen metadata http
        [VM_HOST_IP,5002,5002,"amundsen search http"],   # amundsen search http
   #     [VM_HOST_IP,7474,7474,"neo4j http"],   # neo4j
   #     [VM_HOST_IP,7687,7687,"neo4j bolt"],   # neo4j
   #     [VM_HOST_IP,9200,9200,"elastic search"],   # elastic search      

        [VM_HOST_IP,5010,5010,"amundsen frontend http v2"],   # amundsen frontend http
        [VM_HOST_IP,5453,5453,"amundsen frontend https v2"],   # amundsen frontend 
        [VM_HOST_IP,5011,5011,"amundsen metadata http v2"],   # amundsen metadata http
        [VM_HOST_IP,5012,5012,"amundsen search http v2"],   # amundsen search http
        [VM_HOST_IP,7475,7475,"neo4j http v2"],   # neo4j
        [VM_HOST_IP,7688,7688,"neo4j bolt v2"],   # neo4j
        [VM_HOST_IP,9201,9201,"elastic search v2"],   # elastic search      

        [VM_HOST_IP,5673,5673,"RabbitMQ2 client connections"],   # RabbitMQ client connections        
        [VM_HOST_IP,15673,15673,"RabbitMQ2 management website"], # RabbitMQ management website       
        [VM_HOST_IP,5672,5672,"RabbitMQ client connections"],   # RabbitMQ client connections        
        [VM_HOST_IP,15672,15672,"RabbitMQ management website"], # RabbitMQ management website          
        
        [VM_HOST_IP,5432,5432,"Request Postgresql"], # Postgresql management website          

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
        "python39",
        "docker",
        "docker.setup", 
        "docker.gui-portainer",
        "packer", 
        "aws", 
        "kubectl", 
        "nodejs"
    ]

end