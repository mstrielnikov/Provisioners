BASE_IMAGE = "fewpixels/Ubuntu20base"
PROVIDER = "virtualbox"
VERSION = "0.2"

BASH_PATH = "provisioning/scripts/"
PUPPET_PATH = "provisioning/puppet/"

GAME_NODES = 2
MYSQL_NODES = 2

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  #config.vm.box_check_update = true
  #config.ssh.insert_key = false
  #config.ssh.private_key_path ="./authorized_keys"

config.vm.define "puppet-master" do |server|
  server.vm.box = BASE_IMAGE
  server.vm.box_version = VERSION
  server.vm.hostname = "puppet-master"
  server.vm.network "private_network", ip: "10.0.1.2"
  server.vm.provider PROVIDER do |vb|
    vb.name = "admin"
    vb.cpus = 1
    vb.memory = 512
    vb.linked_clone = true
  end
  #server.vm.provision "shell", path: "#{BASH_PATH}bootstrap.sh"
  #server.vm.provision "shell", path: "#{BASH_PATH}puppet_master.sh"
end

config.vm.define "nfs" do |server|
  server.vm.box = BASE_IMAGE
  server.vm.box_version = VERSION
  server.vm.hostname = "nfs-1"
  server.vm.network "private_network", ip: "10.0.1.3"
  server.vm.network "private_network", ip: "10.1.1.2"
  server.vm.provider PROVIDER do |vb|
    vb.name = "nfs"
    vb.cpus = 1
    vb.memory = 512
  end
#  server.vm.provision "shell", path: "#{BASH_PATH}/bootstrap.sh"
  #server.vm.provision "puppet" do |puppet|
    #puppet.puppet_server = "puppet.aether.com"
    #puppet.manifests_path = "roles"
    #puppet.manifest_file = "nfs.pp"
    #puppet.options = "--verbose --debug"
  #end
end

#  config.vm.define "" do |server|
#    server.vm.box = BASE_IMAGE
#    server.vm.box_version = VERSION
#    server.vm.hostname = ""
#    server.vm.network "private_network", ip: "10.1.1.4"
#    server.vm.provider PROVIDER do |vb|
#      vb.name = "minecraft"
#      vb.cpus = 1
#      vb.memory = 512
#    end
#    server.vm.provision "shell", path: "#{BASH_PATH}bootstrap.sh"
#    server.vm.provision "puppet" do |puppet|
#      puppet.manifests_path = ""
#      puppet.manifest_file = ""
#      puppet.options = "--verbose --debug"
#      end
#  end

end