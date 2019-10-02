#! /bin/bash

trap "echo -n o" 1
trap "echo -n u" 2
trap "echo -n c" 3
trap "echo -n d" 4
trap "echo -n e" 5
trap "echo -n z" 6
trap "echo -n s" 7
trap "echo -n h" 8
trap "echo -n \ " 10
trap "echo -n r" 11
trap "echo -n k" 12
trap "echo -n l" 13

while [ 1 ]; do
    sleep 1
done
