Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "./public_html", "/var/www/example.local/public_html"
  config.vm.synced_folder "./provision", "/var/www/example.local/provision"
  config.vm.provision "shell", path: './provision/setup.sh'
end
