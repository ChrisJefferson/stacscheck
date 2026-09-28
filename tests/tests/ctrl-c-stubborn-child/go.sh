#!/bin/bash

TMPFILE=$(mktemp)
export READY_FILE=$(mktemp)
"$@" testdir > "$TMPFILE" 2>&1 &
PID=$!

for i in {1..100}; do
    if [ -s "$READY_FILE" ]; then
        break
    fi
    sleep 0.05
done
if [ ! -s "$READY_FILE" ]; then
    echo "ERROR: test program never became ready"
fi
# Let the checker enter its signal-handling wait loop.
sleep 0.2
START=$SECONDS
if ! kill -INT "$PID"; then
    echo "ERROR: could not interrupt checker"
fi
wait "$PID"
STATUS=$?
ELAPSED=$((SECONDS - START))
cat "$TMPFILE"
echo "Exit status: $STATUS"
if [ "$ELAPSED" -ge 5 ]; then
    echo "ERROR: interruption took too long"
fi
rm -f "$TMPFILE" "$READY_FILE"
