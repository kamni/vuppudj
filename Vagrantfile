# -*- mode: ruby -*-
# vi: set ft=ruby :

cfgfile = File.dirname(__FILE__) + '/ports.cfg'
cfg = File.read cfgfile
eval cfg

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.provider :virtualbox do |vb|
  #  vb.gui = true
  #end
  config.vm.box = "hashicorp/precise64"
  config.vm.box_url = "https://vagrantcloud.com/hashicorp/precise64"
  PORTS.each do |port|
    config.vm.network "forwarded_port", guest: port[0], host: port[1], auto_correct: true
  end
  config.vm.provision :shell, :path => "bootstrap.sh"
end
