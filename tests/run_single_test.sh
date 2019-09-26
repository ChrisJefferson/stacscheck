#!/usr/bin/env bash

set -o errexit

CURRENTDIR=$(pwd)
CHECKPROG=$(pwd)/../stacscheck

VERSION=$($CHECKPROG --version)

FILT='s|\Q'$CURRENTDIR'\E|DIR|g'
FILT2='s|\Q'$VERSION'\E|VERSION|g'

function filtfile {
    perl -pe ${FILT} $1 | perl -pe ${FILT2}
}

echo Testing $1
mkdir -p /tmp/$1/
diff $1/output.txt  <( cd $1 && ./go.sh "$CHECKPROG" | perl -pe ${FILT} | perl -pe ${FILT2})
diff $1/verbose-output.txt <( cd $1 && ./go.sh "$CHECKPROG" --verbose | perl -pe ${FILT} | perl -pe ${FILT2})
diff $1/output.html <(cd $1 && ./go.sh "$CHECKPROG" --html /tmp/$1/html.tmp > /dev/null && perl -pe ${FILT} /tmp/$1/html.tmp | perl -pe ${FILT2} && rm /tmp/$1/html.tmp)
diff $1/output.json <(cd $1 && ./go.sh "$CHECKPROG" --json /tmp/$1/json.tmp > /dev/null && perl -pe ${FILT} /tmp/$1/json.tmp | perl -pe ${FILT2} && rm /tmp/$1/json.tmp)
rm -f /tmp/$1/try-harder.html /tmp/$1/try-harder.json /tmp/$1/try-harder.txt
( cd $1 && ./go.sh "$CHECKPROG" --tryharder --html /tmp/$1/try-harder.html --json /tmp/$1/try-harder.json || true) > /tmp/$1/try-harder.txt
if [ -e /tmp/$1/try-harder.html ]; then
    diff $1/try-harder.html <(filtfile /tmp/$1/try-harder.html)
fi;
if [ -e /tmp/$1/try-harder.json ]; then
    diff $1/try-harder.json <(filtfile /tmp/$1/try-harder.json)
fi;
if [ -e /tmp/$1/try-harder.txt ]; then
    diff $1/try-harder.txt <(filtfile /tmp/$1/try-harder.txt)
fi;

rm -f /tmp/$1/verbose-test.html /tmp/$1/verbose-test.json /tmp/$1/verbose-test.txt
( cd $1 && ./go.sh "$CHECKPROG" --verbose --html /tmp/$1/verbose-test.html --json /tmp/$1/verbose-test.json || true) > /tmp/$1/verbose-test.txt
if [ -e /tmp/$1/verbose-test.html ]; then
    diff $1/verbose-test.html <(filtfile /tmp/$1/verbose-test.html)
fi;
if [ -e /tmp/$1/try-harder.json ]; then
    diff $1/verbose-test.json <(filtfile /tmp/$1/verbose-test.json)
fi;
if [ -e /tmp/$1/try-harder.txt ]; then
    diff $1/verbose-test.txt <(filtfile /tmp/$1/verbose-test.txt)
fi;
