#!/bin/bash

cat
for i in $(seq 100000); do echo -n "LONGLONG"$i; done
