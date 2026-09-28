#!/bin/bash

# The child exits on its own even when testing a broken checker.
(
    exec 2>&-
    echo 'WRONG OUTPUT'
    sleep 25
) &
