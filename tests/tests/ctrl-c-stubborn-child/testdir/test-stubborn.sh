#!/bin/bash

trap "exit 0" INT TERM
bash "$TESTDIR/stubborn.sh" &
wait "$!"
