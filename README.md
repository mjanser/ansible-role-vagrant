# Ansible Role: vagrant

An Ansible role that installs Vagrant with plugins on Fedora.

## Requirements

For configuring firewalld the service has to run and the package `python-firewall` needs to be installed.

## Role Variables

Available variables are listed below, along with default values:

    vagrant_libvirt: yes
    vagrant_virtualbox: yes
    vagrant_lxc: yes
    vagrant_firewalld: no
    vagrant_plugin_packages: []
    vagrant_plugins: []

### Providers

The different Vagrant providers can be enabled or disabled with the variables `vagrant_libvirt`, `vagrant_virtualbox` and `vagrant_lxc`.

### Firewall

If the variable `vagrant_firewalld` is set to `yes` the services `nfs`, `mountd` and `rpc-bind` will be opened for the internal zone.
Additionally the port `2049/udp` will be opened.

### Plugins

In the variable `vagrant_plugin_packages` you can define a list of plugin packages to install.
The name of the package has to be defined in the `name` key, see example below.
Make sure those packages are actually available in your distribution.

The other option is putting the plugins in the variable `vagrant_plugins`.
This way they will be installed using the command `vagrant plugin install` per user (not globally).
Each item in the list must have the keys `name` and `user`. The key `name` defines the plugin name, `user` the user which is used to install the plugin.
The role tries to install all required development tools for compiling the plugins, but maybe for some plugins there are missing dependencies (pull requests welcome).

## Dependencies

None

## Example Playbook

    - hosts: all
      roles:
        - { role: mjanser.vagrant }
      vars:
        vagrant_plugin_packages:
          - name: vagrant-hostmanager
        vagrant_plugins:
          - user: vagrant
            name: vagrant-vbguest

## License

MIT
