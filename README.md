# Ansible Role: vagrant

An Ansible role that installs Vagrant with plugins on Fedora.

## Requirements

For configuring firewalld the service has to run and the package `python-firewall` needs to be installed.

## Role Variables

Available variables are listed below, along with default values:

    vagrant_lxc: true
    vagrant_firewalld: false
    vagrant_plugins: []

## Dependencies

None

## Example Playbook

    - hosts: all
      roles:
        - { role: mjanser.vagrant }
      vars:
        vagrant_plugins:
          - user: vagrant
            plugin: vagrant-hostmanager

## License

MIT
