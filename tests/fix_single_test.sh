#!/bin/bash

CURRENTDIR=$(pwd)
CHECKPROG=$(pwd)/../stacscheck

VERSION=$($CHECKPROG --version)

FILT='s|\Q'$CURRENTDIR'\E|DIR|g'
FILT2='s|\Q'$VERSION'\E|VERSION|g'

function filtfile {
    perl -pe ${FILT} $1 | perl -pe ${FILT2}
}


CHECKPROG=$(pwd)/../stacscheck
mkdir -p /tmp/$1/$1/

rm -f $1/try-harder.* $1/output.* $1/verbose-*.txt

echo Testing $1
( cd $1 && ./go.sh "$CHECKPROG" | perl -pe ${FILT} | perl -pe ${FILT2}) > $1/output.txt
( cd $1 && ./go.sh "$CHECKPROG" --verbose | perl -pe ${FILT} | perl -pe ${FILT2} ) > $1/verbose-output.txt
( cd $1 && ./go.sh "$CHECKPROG" --html /tmp/$1/html.tmp > /dev/null && perl -pe ${FILT} /tmp/$1/html.tmp | perl -pe ${FILT2} && rm /tmp/$1/html.tmp) > $1/output.html
( cd $1 && ./go.sh "$CHECKPROG" --json /tmp/$1/json.tmp > /dev/null && perl -pe ${FILT} /tmp/$1/json.tmp | perl -pe ${FILT2} && rm /tmp/$1/json.tmp) > $1/output.json

rm -f /tmp/$1/try-harder.html /tmp/$1/try-harder.json /tmp/$1/try-harder.txt
( cd $1 && ./go.sh "$CHECKPROG" --tryharder --html /tmp/$1/try-harder.html --json /tmp/$1/try-harder.json | perl -pe ${FILT} | perl -pe ${FILT2}) > /tmp/$1/try-harder.txt
perl -pe ${FILT} /tmp/$1/try-harder.html | perl -pe ${FILT2} > $1/try-harder.html
perl -pe ${FILT} /tmp/$1/try-harder.json | perl -pe ${FILT2} > $1/try-harder.json
perl -pe ${FILT} /tmp/$1/try-harder.txt  | perl -pe ${FILT2} > $1/try-harder.txt

rm -f /tmp/$1/verbose-test.html /tmp/$1/verbose-test.json /tmp/$1/verbose-test.txt
( cd $1 && ./go.sh "$CHECKPROG" --verbose --html /tmp/$1/verbose-test.html --json /tmp/$1/verbose-test.json | perl -pe ${FILT} | perl -pe ${FILT2} ) > /tmp/$1/verbose-test.txt
perl -pe ${FILT} /tmp/$1/verbose-test.html | perl -pe ${FILT2} > $1/verbose-test.html
perl -pe ${FILT} /tmp/$1/verbose-test.json | perl -pe ${FILT2} > $1/verbose-test.json
perl -pe ${FILT} /tmp/$1/verbose-test.txt  | perl -pe ${FILT2} > $1/verbose-test.txt
