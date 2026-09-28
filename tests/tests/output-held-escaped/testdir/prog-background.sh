#!/bin/bash

# Escape the process group but still exit on our own after a bounded time.
perl -MPOSIX=setsid -e '
    setsid() >= 0 or die "setsid failed: $!";
    close STDERR;
    $| = 1;
    print "Output from escaped child\n";
    sleep 25;
' &
