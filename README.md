# OSX Playbook

An Ansible Playbook for web developers using OS X

## Getting Started

Use the next commands to install ansible and run the playbooks

### Install XCode Command-Line tools
 
    xcode-select --install

### Install ansible

    sudo pip install ansible

### Install ansible requirements

    ansible-galaxy install -r requirements.yml

### Run the playbook

    ansible-playbook all.yml

If you want to run only the specific playbooks if you can use

    ansible-playbook {{name}}.yml
