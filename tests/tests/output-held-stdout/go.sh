#!/bin/bash

"$@" testdir 2>&1
echo "Exit status: $?"
