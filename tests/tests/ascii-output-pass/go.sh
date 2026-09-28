#!/bin/bash

PYTHONIOENCODING=ascii:strict "$@" testdir 2>&1
echo "Exit status: $?"
