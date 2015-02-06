# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_VERSION = "2"

Vagrant.configure(VAGRANT_VERSION) do |config|

  config.vm.box = "hashicorp/precise64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 512
  end

  config.ssh.insert_key = false

  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.provision :puppet do |puppet|
    #puppet.options = "--verbose --debug"
    puppet.manifests_path  = 'puppet\manifests'
    puppet.module_path = 'puppet\modules'
    puppet.manifest_file   = 'init.pp'
  end
end
