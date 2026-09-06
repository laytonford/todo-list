# COSC349 Assignment 1

## To-Do List Overview

This project is a simple to-do list application developed for COSC349.

Users can:

- View tasks
- Add tasks
- Mark tasks as complete or incomplete
- Delete tasks

The application runs across three virtual machines:

- **Web VM** (`192.168.56.10`) – generates the frontend and receives API requests
- **App VM** (`192.168.56.11`) – runs the PHP application logic
- **Database VM** (`192.168.56.12`) – stores task data in a MySQL database

Application requests follow this path: Browser -> Web VM -> App VM -> Database VM

## Tools

The project uses:

- Vagrant – creates and manages the virtual machines
- VirtualBox – runs the virtual machines
- Apache – generates the frontend and PHP API
- PHP – handles application logic
- MySQL – stores task data in the database
- Git – version control

## Deployment

Clone the repository and enter the project directory:

    git clone <https://github.com/laytonford/todo-list>
    cd todo-list

Deploy the system with:

    vagrant up

This creates and provisions all three VMs automatically.

## Access

Open the app in a browser with: http://192.168.56.10

This comes preloaded with some test data to quickly demonstrate how the project works

## Verification

Run: 

    ./verify.sh

The script checks that all three VMs are running and performs an application request that retrieves stored task data through the VM chain.

## Stopping

To safely stop the VMs use: 

    vagrant halt

To start them again use: 

    vagrant up

## Removal

To remove all VMs created by the project use: 

    vagrant destroy -f

## Development and Redeployment

Frontend files are located in: www/

Backend application logic is located in: app/api.php

Changes to frontend or PHP files can be seen by refreshing the browser.

Provisioning changes can be applied to a specific VM with: 

    vagrant provision <vm-name>


A complete clean rebuild can be performed with:

    vagrant destroy -f
    vagrant up

Verify deployment and see the made changes with: 

    ./verify.sh 

## Project Structure

    todo-list/
    ├── app/
    │   └── api.php
    ├── www/
    │   ├── index.html
    │   └── style.css
    ├── Vagrantfile
    ├── build-webserver-vm.sh
    ├── build-appserver-vm.sh
    ├── build-dbserver-vm.sh
    ├── web-website.conf
    ├── app-website.conf
    ├── setup-database.sql
    ├── verify.sh
    ├── .gitattributes
    └── .gitignore