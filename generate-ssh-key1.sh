#!/bin/bash
set -e

cd /home/vagrant/.ssh/ 2>&1
ssh-keygen -m PEM -t ed25519 -b 4096 -f myansible.key -N "" -C "vagrant@srv" 2>&1
cat myansible.key.pub >> authorized_keys 2>&1
