#!/usr/bin/env bash

install_docker() {
    step "===== Installing docker ====="
    sudo apt-get -qq update
    sudo apt-get remove docker docker-engine docker.io containerd runc

    sudo apt-get install -yqq\
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

        
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    buster stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -qq
    sudo apt-get install -yqq docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo groupadd docker
    sudo gpasswd -a $USER docker
    newgrp docker
    # Add vagrant to docker group
    sudo groupadd docker
    sudo gpasswd -a vagrant docker
    # Setup docker daemon host
    # Read more about docker daemon https://docs.docker.com/engine/reference/commandline/dockerd/
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
}

install_openssh() {
    step "===== Installing openssh ====="
    sudo apt-get update
    sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
    sudo apt-get install -y openssh-server
    sudo systemctl enable ssh
}

install_tools() {
    sudo apt install -y python3 git 

}



main() {
    install_tools
    install_openssh
    install_docker
}

main