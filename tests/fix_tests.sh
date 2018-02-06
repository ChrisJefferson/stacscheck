#!/bin/bash

mkdir tests/checkout-baddir/testdir/abc
chmod -rwx tests/checkout-baddir/testdir/abc

CURRENTDIR=$(pwd)
echo Current dir is $CURRENTDIR
CHECKPROG=$(pwd)/../stacscheck

VERSION=$($CHECKPROG --version)

FILT='s|'$CURRENTDIR'|DIR|g'
FILT2='s|'$VERSION'|VERSION|g'

function filtfile {
    sed ${FILT} $1 | sed ${FILT2}
}


CHECKPROG=$(pwd)/../stacscheck
for i in $(ls -d tests/*/); do
    echo Testing $i
    ( cd $i && ./go.sh "$CHECKPROG" | sed ${FILT} | sed ${FILT2}) > $i/output.txt
    ( cd $i && ./go.sh "$CHECKPROG" --verbose | sed ${FILT} | sed ${FILT2} ) > $i/verbose-output.txt
    ( cd $i && ./go.sh "$CHECKPROG" --html /tmp/html.tmp > /dev/null && sed ${FILT} /tmp/html.tmp | sed ${FILT2} && rm /tmp/html.tmp) > $i/output.html
    ( cd $i && ./go.sh "$CHECKPROG" --json /tmp/json.tmp > /dev/null && sed ${FILT} /tmp/json.tmp | sed ${FILT2} && rm /tmp/json.tmp) > $i/output.json

    rm -f /tmp/try-harder.html /tmp/try-harder.json /tmp/try-harder.txt
    ( cd $i && ./go.sh "$CHECKPROG" --tryharder --html /tmp/try-harder.html --json /tmp/try-harder.json | sed ${FILT} | sed ${FILT2}) > /tmp/try-harder.txt
    sed ${FILT} /tmp/try-harder.html | sed ${FILT2} > $i/try-harder.html
    sed ${FILT} /tmp/try-harder.json | sed ${FILT2} > $i/try-harder.json
    sed ${FILT} /tmp/try-harder.txt  | sed ${FILT2} > $i/try-harder.txt

    rm -f /tmp/verbose-test.html /tmp/verbose-test.json /tmp/verbose-test.txt
    ( cd $i && ./go.sh "$CHECKPROG" --verbose --html /tmp/verbose-test.html --json /tmp/verbose-test.json | sed ${FILT} | sed ${FILT2} ) > /tmp/verbose-test.txt
    sed ${FILT} /tmp/verbose-test.html | sed ${FILT2} > $i/verbose-test.html
    sed ${FILT} /tmp/verbose-test.json | sed ${FILT2} > $i/verbose-test.json
    sed ${FILT} /tmp/verbose-test.txt  | sed ${FILT2} > $i/verbose-test.txt
done
