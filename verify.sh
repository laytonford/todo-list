#!/bin/bash

echo "Checking VM status..."

if ! vagrant status | grep -q "web.*running"; then
    echo "FAIL: web VM is not running"
    exit 1
fi

if ! vagrant status | grep -q "app.*running"; then
    echo "FAIL: app VM is not running"
    exit 1
fi

if ! vagrant status | grep -q "db.*running"; then
    echo "FAIL: db VM is not running"
    exit 1
fi

echo "PASS: all VMs are running"

echo
echo "Checking application data through the VM chain..."

response=$(vagrant ssh web -c "curl -s http://192.168.56.11/api.php")

echo "$response"

if echo "$response" | grep -q "description"; then
    echo "PASS: application returned stored task data"
else
    echo "FAIL: application did not return task data"
    exit 1
fi