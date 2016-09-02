Stacscheck v1.0.0
================

A stacscheck specification is a directory.

It can optionally contain a configuration file called practical.config

practical.config must begin with the single line:

[info]

It then must contain the following three lines:

practical = <practical name>
course = <course name>
srcdir = <name of directory>

Where srcdir specifies the name of the directory the practical's source is contained in.


Running tests
-------------

Each test is stored as a shell script, ending in 'sh'. There are 4 types of tests.
They can be identified by the beginning of their name.

* Scripts starting 'build' are *build scripts*. If the script fails, then the output
  of the script is printed, and no more tests in this directory are run.

* Scripts starting 'test' are *standard tests*. If the script fails, then the output
  of the script is printed.

* Scripts starting 'info' are *info scripts*. The output of the script is always printed.
  This is intended for code such as code checking tools.

* Scripts starting 'prog' are *program scripts*. The output of this script is automatically
  diffed against a known good output.

  The exact algorithm is:
  * For each filename F ending '.out'
    * construct the filename Fin by replacing the '.out' with '.in'
    * Run the program script, with Fin as input to the program (if it exists),
      and diff the output against F

  The diffing algorithm ignores whitespace at the end of lines, and blank lines.

Then, recursively look in each subdirectory, and run this process again.

Files are always considered in alphabetical order of filename.

Environment variables
---------------------


The following environment variable will be defined when any external program is run.

* TESTDIR : The full directory name of the test script being run was contained.
            This can be used to read other files.

