#!/usr/bin/env bash

install_python() {
    sudo apt-get update -qq 
    sudo apt-get install -y python3 \
        python3-pip 
}

install_ansible(){
    python3 -m pip install --user ansible
}

execute_ansible(){
    pushd /ansible > /dev/null
        export PATH=$PATH:/root/.local/bin
        ansible-playbook --connection=local --inventory 127.0.0.1, main.yml --extra-vars "service=$(hostname)"
    popd > /dev/null
}


main() {
    install_python
    install_ansible
    execute_ansible
}

main

