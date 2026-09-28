#!/bin/bash

echo '[{"name":"looks successful","returnval":0,"trafficlight":"GREEN","stdout":"finished","stderr":""}]'
# The child exits on its own even when testing a broken checker.
(
    exec 1>&-
    echo 'Multipart output before termination' >&2
    sleep 25
) &
