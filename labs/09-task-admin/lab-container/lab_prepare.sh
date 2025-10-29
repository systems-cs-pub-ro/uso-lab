#!/bin/bash

install_docker () {
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
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
    cleanup)
        ;;
    *)
        echo "Wrong operation"
        exit 1
        ;;
    esac
}

check_section () {
    case $1 in
    all)
        ;;
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

if test $operation == "cleanup"; then
    sudo docker stop $(sudo docker ps -a -q) 2> /dev/null
    sudo docker rm $(sudo docker ps -a -q) 2> /dev/null
    sudo docker network ls 2> /dev/null | grep lab-container | cut -d" " -f1 | xargs -I{} sudo docker network rm {} 2> /dev/null
    sudo docker network ls 2> /dev/null | grep labcontainer | cut -d" " -f1 | xargs -I{} sudo docker network rm {} 2> /dev/null
    sudo docker image ls 2> /dev/null | grep lab09 | cut -d" " -f1 | xargs -I{} sudo docker image rm {} 2> /dev/null
    exit 0
fi

if test $operation == "delete"; then
    sudo docker compose down
    sudo docker image rm gitlab.cs.pub.ro:5050/uso/uso-lab/lab09-${section}
    exit 0
fi

if test $operation == "stop"; then
    sudo docker compose stop ${section}
    exit 0
fi

if test $# -lt 2; then
    echo "./lab_prepare.sh <operation> [<section name>]"
    exit 1
fi

check_section $section

if test $operation == "install"; then
    if test $section == "all"; then
        sudo docker compose up -d
    else
        sudo docker compose up -d $section
        sudo docker compose up -d dhcp
    fi

fi

if test $operation == "connect"; then
    if test $section == "dropbox"; then
        sudo docker exec --user dropbox -it lab09-${section} bash
    else
        sudo docker exec -it lab09-${section} bash
    fi
fi
