#!/bin/bash

mkdir tests/checkout-baddir/testdir/abc
chmod -rwx tests/checkout-baddir/testdir/abc

BADFILES="simpletest-badperm1/testdir/practical.config simpletest-badperm2/testdir/catter/progcat.sh simpletest-badperm3/testdir/catter/blanks.in simpletest-badperm4/testdir/catter/blanks.out"
(cd tests && touch $BADFILES && chmod -rx $BADFILES)

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

(cd tests && rm -f $BADFILES)
