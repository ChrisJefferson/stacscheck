#!/bin/bash

CHECKPROG=$(pwd)/../stacscheck
for i in $(ls -d tests/*/); do
    echo Testing $i
    diff $i/output.txt <( cd $i && ./go.sh "$CHECKPROG")
    diff $i/verbose-output.txt <( cd $i && ./go.sh "$CHECKPROG" --verbose)
    diff $i/output.html <(cd $i && ./go.sh "$CHECKPROG" --html /tmp/html.tmp > /dev/null && cat /tmp/html.tmp && rm /tmp/html.tmp)
    diff $i/output.json <(cd $i && ./go.sh "$CHECKPROG" --json /tmp/json.tmp > /dev/null && cat /tmp/json.tmp && rm /tmp/json.tmp)
    rm -f /tmp/try-harder.html /tmp/try-harder.json /tmp/try-harder.txt
    ( cd $i && ./go.sh "$CHECKPROG" --tryharder --html /tmp/try-harder.html --json /tmp/try-harder.json) > /tmp/try-harder.txt
    diff /tmp/try-harder.html $i/try-harder.html
    diff /tmp/try-harder.json $i/try-harder.json
    diff /tmp/try-harder.txt $i/try-harder.txt
done
