#!/bin/bash

mkdir tests/checkout-baddir/testdir/abc
chmod -rwx tests/checkout-baddir/testdir/abc

set -o errexit

CURRENTDIR=$(pwd)
echo Current dir is $CURRENTDIR
CHECKPROG=$(pwd)/../stacscheck

VERSION=$($CHECKPROG --version)

FILT='s|\Q'$CURRENTDIR'\E|DIR|g'
FILT2='s|\Q'$VERSION'\E|VERSION|g'

function filtfile {
    perl -pe ${FILT} $1 | perl -pe ${FILT2}
}

echo $(ls -d tests/*/) | xargs -P16 -n1 ./fix_single_test.sh
