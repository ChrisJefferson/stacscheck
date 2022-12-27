#!/bin/bash

# Clear away any existing coverage files
rm -f .coverage
rm -rf coverage
mkdir coverage

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

set -eu

ls -d tests/*/ | (
    # On CI we can't run in parallel as it causes timeouts
    if command -v parallel &> /dev/null && [ -z ${CI+x} ]; then
        echo Using parallel
        parallel --willcite ./run_single_test.sh
    else
        echo Using xargs
        xargs -n1 ./run_single_test.sh
    fi
)

if command -v coverage &> /dev/null; then
   coverage combine coverage/*
   coverage html
fi;

(cd tests && rm -f $BADFILES)
