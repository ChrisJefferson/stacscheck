#!/bin/bash

set -euo pipefail

cgcreate -g memory,cpuacct:/stacscheck-${USER}/$1
cgset -r memory.limit_in_bytes=1g /stacscheck-${USER}/$1
cgset -r memory.memsw.limit_in_bytes=1g /stacscheck-${USER}/$1