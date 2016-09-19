#!/bin/bash

CHECKPROG=$(pwd)/../stacscheck
for i in $(ls -d tests/*/); do
    echo Testing $i
    ( cd $i && ./go.sh "$CHECKPROG") > $i/output.txt
    ( cd $i && ./go.sh "$CHECKPROG" --verbose ) > $i/verbose-output.txt
    ( cd $i && ./go.sh "$CHECKPROG" --html /tmp/html.tmp > /dev/null && cat /tmp/html.tmp && rm /tmp/html.tmp) > $i/output.html
    ( cd $i && ./go.sh "$CHECKPROG" --json /tmp/json.tmp > /dev/null && cat /tmp/json.tmp && rm /tmp/json.tmp) > $i/output.json
    rm -f /tmp/try-harder.html /tmp/try-harder.json /tmp/try-harder.txt
    ( cd $i && ./go.sh "$CHECKPROG" --tryharder --html /tmp/try-harder.html --json /tmp/try-harder.json) > /tmp/try-harder.txt
    cat /tmp/try-harder.html > $i/try-harder.html
    cat /tmp/try-harder.json > $i/try-harder.json
    cat /tmp/try-harder.txt  > $i/try-harder.txt
done
