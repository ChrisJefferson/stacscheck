#!/bin/bash
# Multi test demonstrating traffic light colors
cat << 'EOF'
[
  {"name": "green-pass", "trafficlight": "GREEN", "returnval": 0, "stdout": "All checks passed!"},
  {"name": "yellow-warn", "trafficlight": "YELLOW", "returnval": 0, "stdout": "Minor style warning on line 42"},
  {"name": "amber-issue", "trafficlight": "AMBER", "returnval": 0, "stdout": "Significant warning: deprecated function used", "stderr": "Consider updating to new API"},
  {"name": "red-fail", "trafficlight": "RED", "returnval": 1, "stdout": "Critical error detected", "stderr": "Memory leak in function process()"}
]
EOF
