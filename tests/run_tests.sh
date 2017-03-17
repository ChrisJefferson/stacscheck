#!/bin/bash

mkdir tests/checkout-baddir/testdir/abc
chmod -rwx tests/checkout-baddir/testdir/abc
# set -o errexit 

CURRENTDIR=$(pwd)
FILT='s|'$CURRENTDIR'|DIR|g'

function filtfile {
    sed ${FILT} $1
}

echo Current dir is $CURRENTDIR
CHECKPROG=$(pwd)/../stacscheck
for i in $(ls -d tests/*/); do
    echo Testing $i
    diff $i/output.txt  <( cd $i && ./go.sh "$CHECKPROG" | sed ${FILT})
    diff $i/verbose-output.txt <( cd $i && ./go.sh "$CHECKPROG" --verbose | sed ${FILT})
    diff $i/output.html <(cd $i && ./go.sh "$CHECKPROG" --html /tmp/html.tmp > /dev/null && sed ${FILT} /tmp/html.tmp && rm /tmp/html.tmp)
    diff $i/output.json <(cd $i && ./go.sh "$CHECKPROG" --json /tmp/json.tmp > /dev/null && sed ${FILT} /tmp/json.tmp && rm /tmp/json.tmp)
    rm -f /tmp/try-harder.html /tmp/try-harder.json /tmp/try-harder.txt
    ( cd $i && ./go.sh "$CHECKPROG" --tryharder --html /tmp/try-harder.html --json /tmp/try-harder.json || true) > /tmp/try-harder.txt
    if [ -e /tmp/try-harder.html ]; then
        diff $i/try-harder.html <(filtfile /tmp/try-harder.html)
    fi;
    if [ -e /tmp/try-harder.json ]; then
        diff $i/try-harder.json <(filtfile /tmp/try-harder.json)
    fi;
    if [ -e /tmp/try-harder.txt ]; then
        diff $i/try-harder.txt <(filtfile /tmp/try-harder.txt)
    fi;

     ( cd $i && ./go.sh "$CHECKPROG" --verbose --html /tmp/verbose-test.html --json /tmp/verbose-test.json || true) > /tmp/verbose-test.txt
    if [ -e /tmp/verbose-test.html ]; then
        diff $i/verbose-test.html <(filtfile /tmp/verbose-test.html)
    fi;
    if [ -e /tmp/try-harder.json ]; then
        diff $i/verbose-test.json <(filtfile /tmp/verbose-test.json)
    fi;
    if [ -e /tmp/try-harder.txt ]; then
        diff $i/verbose-test.txt <(filtfile /tmp/verbose-test.txt)
    fi;
done
