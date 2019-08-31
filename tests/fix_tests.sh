#!/bin/bash

mkdir tests/checkout-baddir/testdir/abc
chmod -rwx tests/checkout-baddir/testdir/abc

CURRENTDIR=$(pwd)
echo Current dir is $CURRENTDIR
CHECKPROG=$(pwd)/../stacscheck

VERSION=$($CHECKPROG --version)

FILT='s|\Q'$CURRENTDIR'\E|DIR|g'
FILT2='s|\Q'$VERSION'\E|VERSION|g'

function filtfile {
    perl -pe ${FILT} $1 | perl -pe ${FILT2}
}


CHECKPROG=$(pwd)/../stacscheck
for i in $(ls -d tests/*/); do
    echo Testing $i
    ( cd $i && ./go.sh "$CHECKPROG" | perl -pe ${FILT} | perl -pe ${FILT2}) > $i/output.txt
    ( cd $i && ./go.sh "$CHECKPROG" --verbose | perl -pe ${FILT} | perl -pe ${FILT2} ) > $i/verbose-output.txt
    ( cd $i && ./go.sh "$CHECKPROG" --html /tmp/html.tmp > /dev/null && perl -pe ${FILT} /tmp/html.tmp | perl -pe ${FILT2} && rm /tmp/html.tmp) > $i/output.html
    ( cd $i && ./go.sh "$CHECKPROG" --json /tmp/json.tmp > /dev/null && perl -pe ${FILT} /tmp/json.tmp | perl -pe ${FILT2} && rm /tmp/json.tmp) > $i/output.json

    rm -f /tmp/try-harder.html /tmp/try-harder.json /tmp/try-harder.txt
    ( cd $i && ./go.sh "$CHECKPROG" --tryharder --html /tmp/try-harder.html --json /tmp/try-harder.json | perl -pe ${FILT} | perl -pe ${FILT2}) > /tmp/try-harder.txt
    perl -pe ${FILT} /tmp/try-harder.html | perl -pe ${FILT2} > $i/try-harder.html
    perl -pe ${FILT} /tmp/try-harder.json | perl -pe ${FILT2} > $i/try-harder.json
    perl -pe ${FILT} /tmp/try-harder.txt  | perl -pe ${FILT2} > $i/try-harder.txt

    rm -f /tmp/verbose-test.html /tmp/verbose-test.json /tmp/verbose-test.txt
    ( cd $i && ./go.sh "$CHECKPROG" --verbose --html /tmp/verbose-test.html --json /tmp/verbose-test.json | perl -pe ${FILT} | perl -pe ${FILT2} ) > /tmp/verbose-test.txt
    perl -pe ${FILT} /tmp/verbose-test.html | perl -pe ${FILT2} > $i/verbose-test.html
    perl -pe ${FILT} /tmp/verbose-test.json | perl -pe ${FILT2} > $i/verbose-test.json
    perl -pe ${FILT} /tmp/verbose-test.txt  | perl -pe ${FILT2} > $i/verbose-test.txt
done
