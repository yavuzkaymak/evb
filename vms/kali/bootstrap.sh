#!/usr/bin/env bash

install_docker() {
    step "===== Installing docker ====="
    sudo apt update
    sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    if [ $? -ne 0 ]; then
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    fi
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo groupadd docker
    sudo gpasswd -a $USER docker
    # Add vagrant to docker group
    sudo groupadd docker
    sudo gpasswd -a vagrant docker
    # Setup docker daemon host
    # Read more about docker daemon https://docs.docker.com/engine/reference/commandline/dockerd/
    sed -i 's/ExecStart=.*/ExecStart=\/usr\/bin\/dockerd -H unix:\/\/\/var\/run\/docker.sock -H tcp:\/\/192.168.121.210/g' /lib/systemd/system/docker.service
    sudo systemctl daemon-reload
    sudo systemctl restart docker
}

install_openssh() {
    step "===== Installing openssh ====="
    sudo apt update
    sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
    sudo apt install -y openssh-server
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