#!/bin/bash

echo "Checking VM status..."
echo

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

response=$(vagrant ssh web -c "curl -s -w '\n%{http_code}' http://192.168.56.11/api.php")

body=$(echo "$response" | head -n -1)
status=$(echo "$response" | tail -n 1)

echo
echo "Task Data:"
echo "$body" | python3 -m json.tool
echo

if [ "$status" = "200" ]; then
    echo "PASS: application request completed successfully"
else
    echo "FAIL: application request returned HTTP $status"
    exit 1
fi