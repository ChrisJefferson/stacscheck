#!/bin/bash

CURRENTDIR=$(pwd)
FILT='s|'$CURRENTDIR'|DIR|g'

function filtfile {
    sed ${FILT} $1
}

CHECKPROG=$(pwd)/../stacscheck
for i in $(ls -d tests/*/); do
    echo Testing $i
    ( cd $i && ./go.sh "$CHECKPROG" | sed ${FILT} ) > $i/output.txt
    ( cd $i && ./go.sh "$CHECKPROG" --verbose | sed ${FILT} ) > $i/verbose-output.txt
    ( cd $i && ./go.sh "$CHECKPROG" --html /tmp/html.tmp > /dev/null && sed ${FILT} /tmp/html.tmp && rm /tmp/html.tmp) > $i/output.html
    ( cd $i && ./go.sh "$CHECKPROG" --json /tmp/json.tmp > /dev/null && sed ${FILT} /tmp/json.tmp && rm /tmp/json.tmp) > $i/output.json
    rm -f /tmp/try-harder.html /tmp/try-harder.json /tmp/try-harder.txt
    ( cd $i && ./go.sh "$CHECKPROG" --tryharder --html /tmp/try-harder.html --json /tmp/try-harder.json | sed ${FILT}) > /tmp/try-harder.txt
    sed ${FILT} /tmp/try-harder.html > $i/try-harder.html
    sed ${FILT} /tmp/try-harder.json > $i/try-harder.json
    sed ${FILT} /tmp/try-harder.txt  > $i/try-harder.txt
done
