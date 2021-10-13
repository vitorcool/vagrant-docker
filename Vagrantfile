#import vagrant docker setup from external file vgrant.docker.setup.rb
require_relative "VagrantDockerSetup.rb"
include VagrantDockerSetup

#import all variables from vagrant docker setup file to Key/pair values tp node_provison_args
node_provision_args = { }
VagrantDockerSetup.constants.each do |c|
  node_provision_args["#{c}"] = eval(c.to_s)
end

#export all Vagrant docker setup to json format
require 'json'
File.write("./provision/.env.#{VM_HOST_NAME}.json",JSON.pretty_generate(node_provision_args))

if ARGV[0] == "up"
  # Display Vagrant docker setup with Pretty Json format
  puts "************************************************"
  puts JSON.pretty_generate(node_provision_args)
  puts "************************************************"
end

Vagrant.configure("2") do |config|

  # Xenial is a bit old but works best at the moment. 
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

  config.vm.define "#{VM_HOST_NAME}" do |node|

    name = "#{VM_HOST_NAME}"
    ip = "#{VM_HOST_IP}"

    node.vm.hostname  = name
    node.vm.network "private_network", ip: ip, :netmask => '255.255.0.0', :bridge => 'eth0'
    node.vm.provider "virtualbox" do |vb|
      vb.name = name
    end

    for index in 0 ... VM_PORT_FORWARD.size
      port_forward = VM_PORT_FORWARD[index]
      config.vm.network "forwarded_port", guest_ip: port_forward[0], guest: port_forward[1], host: port_forward[2],id: port_forward[3], auto_correct: false
    end

    for index in 0 ... VM_PROVISION.size
      scriptName = VM_PROVISION[index]
      node.vm.provision scriptName, type: "shell", path: "provision/scripts/#{scriptName}.sh", env: node_provision_args, run: "runonce"
    end

  end
  
end
