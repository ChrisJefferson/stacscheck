#!/bin/bash

echo "line 1"
>&2 echo "line 2"
echo "line 3"

for i in $(seq 100000); do echo -n "LONGLONG"$i; done
