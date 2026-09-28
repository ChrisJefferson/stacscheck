#!/bin/bash

trap "" INT TERM
echo "Stubborn program ready"
echo ready > "$READY_FILE"
# Bound the fixture independently of the checker.
sleep 15
