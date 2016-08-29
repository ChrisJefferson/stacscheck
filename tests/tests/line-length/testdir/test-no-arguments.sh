#!/bin/bash

if [[ $( ./student-program.sh ) != "Usage: arg1 arg2 arg3" &&
      $( ./student-program.sh ) != "Usage: arg1 arg2" ]]; then
  echo "Expected 'Usage: arg1 arg2 arg3' or 'Usage: arg1 arg2'."
  echo "Your program printed '$( ./student-program.sh )'"
  exit 1
fi;