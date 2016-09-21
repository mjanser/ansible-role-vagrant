Vagrant.configure('2') do |config|
  config.vm.box = 'obnox/fedora24-64-lxc'
  config.vm.hostname = 'ansible-role-vagrant-fedora-24'

  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder '.', '/vagrant/ansible-role-vagrant'

  config.vm.provision 'shell' do |s|
    s.keep_color = true
    s.path = 'tests/init.sh'
  end
end
