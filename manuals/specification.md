Autocheck v0.4.2
================

Autocheck should be run from the directory containing the submission (scripts assume this directory is the current working directory).


A _practical_ is a directory, which is recursively searched through through by the following algorithm:


autocheck(practdir)

* Execute each file matching the regex 'build.*\.sh'. If any fails, return immediately.
* Execute each file matching the regex 'test.*\.sh'. The test SUCCEEDS if it's return value is 0.
* Execute each file matching the regex 'info.*\.sh'. These are run the same as 'test.*\.sh' tests, but their output is always shown.
* For each file P matching the regex 'prog.*\.sh', for each file Fout matching the regex '.*\.out':
  * Create the name Fin by replacing the '.out' extension of Fout with '.in'.
  * If Fin exists, run P with Fin as stdin, else run P with no stdin.
  * Diff the output of P with Fout, using the diffwhite algorithm described below. The test SUCCEEDS if there are no differences in the diff.
* For each directory D in practdir, run autocheck(D)

Files are always considered in lexicographic order of filename.

The following environment variable will be defined when any external program is run.

* TESTDIR : The full directory name of the test script being run was contained. This can be used to read other files.

