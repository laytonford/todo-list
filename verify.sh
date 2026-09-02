#!/bin/bash

echo "Checking VM status..."
vagrant status

echo
echo "Checking application data through the VM chain..."

vagrant ssh web -c "curl -s http://192.168.56.11/api.php"