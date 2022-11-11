#!/bin/bash

(while true
do
  echo "hi"
done) &
disown
(while true
do
  echo "bad" >&2
done) &
disown
