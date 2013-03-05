# -*- mode: ruby -*-
# vi: set ft=ruby :

# This is a combination of the default Vagrantfile generated by running `vagrant init` with vagrant 1.0.3 and
# Vagrantfile.sample found in sous-chef (https://github.com/michaelklishin/sous-chef) as of 12/12/12.

Vagrant::Config.run do |config|

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.

  # config.vm.box     = "oneiric32_base"
  # config.vm.box_url = "http://files.travis-ci.org/boxes/bases/oneiric32_base_v2.box"

  # Ubuntu 12.04, 32 bit
  # config.vm.box     = "precise32_base"
  # config.vm.box_url = "http://files.travis-ci.org/boxes/bases/precise32_base_v2.box"

  # Ubuntu 12.04, 64 bit
  # config.vm.box     = "precise64_base"
  # config.vm.box_url = "http://files.travis-ci.org/boxes/bases/precise64_base_v2.box"

  # it is HIGHLY recommended to download and install your box instead of specifying config.vm.box_url
  config.vm.box = "precise32_base_v2"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  config.ssh.username = "travis" # using Travis CI box

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # changing nictype partially helps with Vagrant issue #516, VirtualBox NAT interface chokes when
  # # of slow outgoing connections is large (in dozens or more).
  config.vm.customize ["modifyvm", :id, "--nictype1", "Am79C973", "--memory", "1536", "--cpus", "2", "--ioapic", "on"]

  # see https://github.com/mitchellh/vagrant/issues/912
  config.vm.customize ["modifyvm", :id, "--rtcuseutc", "on"]

  config.vm.provision :shell do |sh|
    sh.inline = <<-EOF
      /opt/ruby/bin/gem install chef --no-ri --no-rdoc --no-user-install
    EOF
  end

  config.vm.define :node_tail do |web_config|

    web_config.vm.forward_port 22, 2220
    web_config.vm.forward_port 80, 4567
    web_config.vm.forward_port 8080, 7654

    web_config.vm.network :hostonly, "10.11.12.13"

    web_config.vm.provision :chef_solo do |chef|

      chef.cookbooks_path = ["./cookbooks"]
      chef.roles_path     = ["./roles"]
      chef.data_bags_path = ["./data_bags"]

      chef.encrypted_data_bag_secret_key_path = "./.chef/encrypted_data_bag_secret"

      chef.log_level = :debug

      chef.add_role 'node_tail'
    end
  end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # IF you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  # chef.validation_client_name = "ORGNAME-validator"
end
