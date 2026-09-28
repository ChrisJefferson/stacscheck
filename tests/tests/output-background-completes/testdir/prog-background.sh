#!/bin/bash

# The child exits on its own even when testing a broken checker.
(
    echo 'WRONG OUTPUT'
    sleep 0.2
) &
