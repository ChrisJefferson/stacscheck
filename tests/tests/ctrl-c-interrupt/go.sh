#!/bin/bash

# This test verifies that Ctrl+C (SIGINT) is handled gracefully
# by stacscheck, dumping the program's output before exiting.

TMPFILE=$(mktemp)

# Start stacscheck in background, capturing output
$* testdir > "$TMPFILE" 2>&1 &
PID=$!

# Wait for the test to start running
sleep 1

# Send SIGINT (Ctrl+C) to the stacscheck process
kill -INT $PID 2>/dev/null || true

# Wait for it to finish (with timeout in case it doesn't)
for i in {1..30}; do
    if ! kill -0 $PID 2>/dev/null; then
        break
    fi
    sleep 0.1
done

# Force kill if still running
kill -9 $PID 2>/dev/null || true
wait $PID 2>/dev/null || true

# Output the result
cat "$TMPFILE"
rm -f "$TMPFILE"

# Always exit 0 - the test is about the output content, not exit code
exit 0
