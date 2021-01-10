#!/bin/bash

install_docker () {
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
    sudo service docker start
}

check_operation () {
    case $1 in
    install)
        ;;
    connect)
        ;;
    stop)
        ;;
    delete)
        ;;
    *)
        echo "Wrong operation"
        exit 1
        ;;
    esac
}

check_section () {
    case $1 in
    remote)
        ;;
    local)
        ;;
    ssh-server)
        ;;
    dropbox)
        ;;
    *)
        echo "Wrong section"
        exit 1
    esac
}

if test $# -lt 1; then
    echo "./lab_prepare.sh <operation> [<section name>]"
    exit 1
fi

# Install docker

which docker &> /dev/null
if test $? -ne 0; then
    install_docker
fi

operation=$1
section=$2

check_operation $operation

if test $operation == "delete"; then
    sudo docker-compose down
    sudo docker image rm lab-container_${section}
    exit 0
fi

if test $operation == "stop"; then
    sudo docker-compose stop ${section}
    exit 0
fi

if test $# -lt 2; then
    echo "./lab_prepare.sh <operation> [<section name>]"
    exit 1
fi

check_section $section

if test $operation == "install"; then
    if test $section == "all"; then
        sudo docker-compose up
    else
        sudo docker-compose up -d $section
        sudo docker-compose up -d dhcp
    fi

fi

if test $operation == "connect"; then
    if test $section == "dropbox"; then
        sudo docker exec --user dropbox -it lab-container_${section}_1 bash
    else
        sudo docker exec -it lab-container_${section}_1 bash
    fi
fi

