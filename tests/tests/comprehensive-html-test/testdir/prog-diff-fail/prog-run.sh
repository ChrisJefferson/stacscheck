#!/bin/bash
# This outputs wrong content to show a diff
echo '<wrong>&output"here'
echo "x > y (should be x < y)"
