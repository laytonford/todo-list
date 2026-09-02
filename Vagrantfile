Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-22.04"

  config.vm.define "web" do |web|
    web.vm.hostname = "todo-web"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.provision "shell", path: "build-webserver-vm.sh"
  end

  config.vm.define "app" do |app|
    app.vm.hostname = "todo-app"
    app.vm.network "private_network", ip: "192.168.56.11"
    app.vm.provision "shell", path: "build-appserver-vm.sh"
  end

  config.vm.define "db" do |db|
    db.vm.hostname = "todo-db"
    db.vm.network "private_network", ip: "192.168.56.12"
    db.vm.provision "shell", path: "build-dbserver-vm.sh"

    db.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 2
    end
  end

end