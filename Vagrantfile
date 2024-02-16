# -*- mode: ruby -*-
# vi: set ft=ruby :

$master_mach = 2
$worker_mach = 1

NETWORK_BRIDGE = "enp4s0"
CPUS = 2
MEMORY = 4096

Vagrant.configure("2") do |config|

    # config.vm.boot_timeout = 600 
    config.vm.box_check_update=false
    config.vm.box = "ubuntu/jammy64"

    config.vm.define "srv" do |srv|
        srv.vm.network "private_network", ip: "192.168.1.10"
        srv.vm.network "public_network", ip: "172.10.1.100", bridge: NETWORK_BRIDGE
        srv.vm.hostname = "srv"
        srv.vm.synced_folder "src/", "/home/vagrant/src/" 
        srv.vm.provider "virtualbox" do |vb|   
            vb.gui = false
            vb.memory = MEMORY
            vb.cpus = CPUS
            vb.check_guest_additions = false
            vb.name = "srv"
        end
    end

    #config.vm.provision "ssh-key", type: "shell", path: "generate-ssh-key.sh"

    (1..$master_mach).each do |i|
        config.vm.define "master-#{i}" do |master|
            master.vm.network "private_network", ip: "192.168.1.#{20+i}"
            master.vm.network "public_network", ip: "172.10.1.#{20+i}", bridge: NETWORK_BRIDGE
            #master.vm.network "forwarded_port", guest: 8000, host: 8000,  auto_correct: true
            master.vm.hostname = "master-#{i}"
            master.vm.provider "virtualbox" do |vb|
                vb.gui = false
                vb.memory = MEMORY
                vb.cpus = CPUS
                vb.name = "k8s-master-#{i}"
            end
        end
    end
    
    (1..$worker_mach).each do |i|
        config.vm.define "worker-#{i}" do |worker|
            worker.vm.network "private_network", ip: "192.168.1.#{30+i}"
            worker.vm.network "public_network", ip: "172.10.1.#{30+i}", bridge: NETWORK_BRIDGE
            worker.vm.hostname = "worker-#{i}"
            worker.vm.provider "virtualbox" do |vb|
                vb.gui = false
                vb.memory = MEMORY
                vb.cpus = CPUS
                vb.name = "k8s-worker-#{i}"
            end
        end
    end    
    
    # for linux
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "play.yml"
    end

        #config.vm.provision "shell", path: "src/generate-ssh-key.sh"

    # for windows
      
    # config.vm.provision "ansible_local" do |ansible|
    #     ansible.playbook = "play.yml"
    #     ansible.install_mode = "pip_args_only"
    #     ansible.pip_args = "-r /vagrant/requirements.txt"
    # end    
end