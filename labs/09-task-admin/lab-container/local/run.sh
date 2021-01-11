#!/bin/bash

sysctl net.ipv6.conf.all.disable_ipv6=0
service ssh start

sleep infinity
