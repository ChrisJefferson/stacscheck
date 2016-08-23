Each of these directories contains a script 'go.sh', and 'output.txt'.

The runner for the tests is the script 'run_tests.sh', which goes into each directory and runs the tester.
All go.sh assume that stacscheck.py's location is passed as the only argument.

You might ask, why not use stacscheck to test itself? The answer is that's just getting too clever.
