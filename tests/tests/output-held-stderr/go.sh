#!/bin/bash

"$@" --quiet testdir 2>&1
echo "Exit status: $?"
