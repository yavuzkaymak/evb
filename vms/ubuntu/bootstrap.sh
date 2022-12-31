#!/usr/bin/env bash

install_docker() {
    step "===== Installing docker ====="
    sudo apt-get update
    sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    if [ $? -ne 0 ]; then
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    fi
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo groupadd docker
    sudo gpasswd -a $USER docker
    # Add vagrant to docker group
    sudo groupadd docker
    sudo gpasswd -a vagrant docker
    # Setup docker daemon host
    # Read more about docker daemon https://docs.docker.com/engine/reference/commandline/dockerd/
    sudo systemctl daemon-reload
    sudo systemctl restart docker
}

install_openssh() {
    step "===== Installing openssh ====="
    sudo apt-get -qq update
    sudo apt-get -yq install apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
    sudo apt-get install -yq openssh-server
    sudo systemctl enable ssh
}

install_tools() {
    sudo apt-get update -qq
    sudo apt-get install -yq python3 git code-oss

}

main() {
    install_tools
    install_openssh
    install_docker
}

main