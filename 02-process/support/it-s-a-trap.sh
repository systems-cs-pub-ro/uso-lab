#! /bin/bash

trap "echo IT\'s A TRAP!" SIGINT SIGTERM SIGQUIT

while [ 1 ]; do
    echo "Still running . . . "
    sleep 2
done
