#!/bin/bash

ansible-playbook playbook.yml --syntax-check || exit 1

ansible-playbook playbook.yml --connection=local || exit 1

ansible-playbook playbook.yml --connection=local 2>&1 | tee /tmp/ansible.log

# Remove colors from log file
sed -i -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" /tmp/ansible.log

# Test for idempotence
grep -q "changed=0.*failed=0" /tmp/ansible.log \
    && (echo "Idempotence test: pass" && exit 0) \
    || (echo "Idempotence test: fail" && exit 1)

# Test for deprecation warnings
test -n "$(grep -L 'DEPRECATION WARNING' /tmp/ansible.log)" \
    && (echo "Deprecation test: pass" && exit 0) \
    || (echo "Deprecation test: fail" && exit 1)
