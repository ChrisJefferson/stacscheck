#!/bin/bash

# This test will leave a hanging sleeping process, but
# it disappear after 10 minutes
(sleep 600) &
disown
