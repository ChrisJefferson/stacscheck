#!/bin/bash

"$@" --fail-fast testdir 2>&1
echo "Exit status: $?"
