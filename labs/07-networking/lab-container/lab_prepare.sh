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
    tom)
        ;;
    jerry)
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
    sudo docker exec -it lab-container_${section}_1 bash
fi
