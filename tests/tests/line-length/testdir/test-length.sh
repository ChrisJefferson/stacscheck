#!/bin/bash


./student-program.sh arguments |
  awk '{ if (length > 80) print "Line", NR, "too long, it should be 80 characters or less, it is", length, "\n\"" $0 "\"" }'

