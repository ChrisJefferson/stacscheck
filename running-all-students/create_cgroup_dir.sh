#!/bin/bash

set -euo pipefail

echo "This script sets up 'cgroups', a Linux tool to run students in an"
echo "isolated sandbox. It requires 'sudo' access"
echo "Do not run this script as 'root', just enter password when prompted"
user=$USER
sudo cgcreate -t $user:$user -a $user:$user -g memory,cpuacct:/stacscheck-${user}


