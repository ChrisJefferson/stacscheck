#!/bin/bash

# The child exits on its own even when testing a broken checker.
(
    exec 1>&-
    echo 'WRONG OUTPUT' >&2
    sleep 25
) &
