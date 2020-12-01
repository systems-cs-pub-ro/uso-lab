#!/bin/bash

ip link set down eth0
ip link set down eth1
ip link set down eth2

ip a f eth0
ip a f eth1
ip a f eth2

sleep infinity
