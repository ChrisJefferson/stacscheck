#!/bin/bash

CHECKPROG=$(pwd)/../stacscheck
for i in $(ls -d tests/*/); do
    echo Testing $i
    diff $i/output.txt <( cd $i && ./go.sh "$CHECKPROG")
    diff $i/verbose-output.txt <( cd $i && ./go.sh "$CHECKPROG" --verbose)
    diff $i/output.html <(cd $i && ./go.sh "$CHECKPROG" --html /tmp/html.tmp > /dev/null && cat /tmp/html.tmp && rm /tmp/html.tmp)
    diff $i/output.json <(cd $i && ./go.sh "$CHECKPROG" --json /tmp/json.tmp > /dev/null && cat /tmp/json.tmp && rm /tmp/json.tmp)
done