Vagrant.configure('2') do |config|
  config.vm.box = 'obnox/fedora24-64-lxc'
  config.vm.hostname = 'ansible-role-vagrant-fedora-24'

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.sudo = true
  end

  config.vm.provision 'shell' do |s|
    s.keep_color = true
    s.inline = <<SCRIPT
echo "127.0.0.1" > /etc/ansible/hosts
echo "localhost" > /etc/ansible/inventory
echo "[default]\nroles_path = ../" > ansible.cfg

cd /vagrant/
ansible-playbook playbook.yml --connection=local 2>&1 | tee /tmp/ansible.log

# Remove colors from log file
sed -i -r "s/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" /tmp/ansible.log

# Test for idempotence
grep -q "changed=0.*failed=0" /tmp/ansible.log \
    && (echo "Idempotence test: pass" && exit 0) \
    || (echo "Idempotence test: fail" && exit 1)

# Test for deprecation warnings
test -n "$(grep -L 'DEPRECATION WARNING' /tmp/ansible.log)" \
    && (echo "Deprecation test: pass" && exit 0) \
    || (echo "Deprecation test: fail" && exit 1)
SCRIPT
  end
end
