#!/bin/bash
cat badutf8.txt
>&2 cat badutf8.txt
exit 1

