# OSX Playbook

An Ansible Playbook for web developers using OS X

## Getting Started

Use the next commands to install ansible and run the playbooks

### Install XCode Command-Line tools

    xcode-select --install

### Install pip in OSX

    sudo easy_install pip

### Install ansible

    sudo pip install ansible

### Install ansible requirements

    ansible-galaxy install -r requirements.yml
    chmod -x ./inventory

### Run the playbook

    ansible-playbook all.yml

If you want to run only the specific playbooks, you can use

    ansible-playbook {{name}}.yml

## Common problems

If while running the install.yml playbook some of the casks are missing try to run:

    brew update && brew upgrade brew-cask
