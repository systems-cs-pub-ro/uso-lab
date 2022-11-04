#!/bin/bash

install_docker () {
    sudo apt-get update
    sudo apt-get upgrade
    curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
    sudo usermod -aG docker $USER
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
    sudo docker network ls 2> /dev/null | grep labcontainer | cut -d" " -f1 | xargs -I{} sudo docker network rm {} 2> /dev/null
    sudo docker image ls 2> /dev/null | grep labcontainer | cut -d" " -f1 | xargs -I{} sudo docker image rm {} 2> /dev/null
    exit 0
fi

if test $operation == "delete"; then
    sudo docker-compose down
    sudo docker image rm labcontainer_${section}
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
        sudo docker exec --user dropbox -it labcontainer_${section}_1 bash
    else
        sudo docker exec -it labcontainer_${section}_1 bash
    fi
fi

