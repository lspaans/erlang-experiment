VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.hostname = "erlang-expirement.vagrant.zz"
    config.vm.box = "trusty"
    config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/" +
        "current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    config.vm.provision :shell, path: "deploy.sh"
end
