#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "clean-files.sh <directory>"
    echo "This script cleans up 'bad' files, which can confuse testing"
    echo "At the moment that is files of the forms:"
    echo ".DS_Store"
    echo "._*"
    echo "__MACOSX"
    exit 1
fi;

echo Cleaning in "$1"
find "$1" -name ".DS_Store" -print0 | xargs -0 rm -vrf
find "$1" -name "._*" -print0 | xargs -0 rm -vrf
find "$1" -name "__MACOSX" -print0 | xargs -0 rm -vrf
