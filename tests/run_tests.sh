#!/bin/bash

CHECKPROG=$(pwd)/../stacscheck.py
for i in $(ls -d */); do
    echo Testing $i
    diff $i/output.txt <( cd $i && ./go.sh "$CHECKPROG")
done