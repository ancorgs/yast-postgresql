# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant configuration file
#
# You can tweak the configuration by setting some environment variables:
#
# * VAGRANT_USE_NFS: 'true' if you want to use NFS for synced folders.
# * VAGRANT_MEMORY: set the amount of memory you want to use for the VM (default: 1024).
#
# If you want to add a custom provisioning script, just save it as 'provisioning/custom.sh'
# and it will be executed automatically after 'provisioning/yast.sh'.
Vagrant.configure(2) do |config|
  #
  # Basic configuration
  #
  config.vm.box = "opensuse/openSUSE-42.1-x86_64"

  #
  # Synced folders
  #
  mount_options =
    if ENV["VAGRANT_USE_NFS"] == "true"
      { nfs: true, nfs_version: 3, nfs_udp: true }
    else
      {}
    end
  config.vm.synced_folder ".", "/home/vagrant/project", mount_options

  #
  # Network
  #
  if ENV["VAGRANT_USE_NFS"] == "true"
    config.vm.network "private_network", ip: "192.168.33.9"
  end

  #
  # Misc
  #
  config.vm.hostname = "yast-postgresql"
  config.ssh.forward_x11 = true
  config.ssh.forward_agent = true

  #
  # Provider
  #
  memory = ENV["VAGRANT_MEMORY"] || 1024
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = memory
  end

  config.vm.provider :virtualbox do |vbox|
    vbox.memory = memory
  end

  #
  # Provisioning
  #
  config.vm.provision "shell", privileged: true, path: "provisioning/yast.sh"

  # If a custom.sh script exists, it will be also executed during provisioning.
  if File.exist?("provisioning/custom.sh")
    config.vm.provision "shell", privileged: false, path: "provisioning/custom.sh"
  end
end
