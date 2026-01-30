#!/bin/bash
echo "Starting infinite loop test"
echo "Line 1 of output"
echo "Line 2 of output"
echo "This should be captured" >&2
while true; do
    sleep 0.5
done
