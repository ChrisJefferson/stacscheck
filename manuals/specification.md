Stacscheck v2.0.1
=================

Be sure to read the [quickstart-guide](quickstart-guide.html), for a brief overview,
before reading this document!

A set of tests for `stacscheck` is always stored in a directory containing a configuration file called `practical.config`

`practical.config` must begin with the single line:

`[info]`

It then must contain the following three lines:

```
practical = <practical name>
course = <course name>
srcdir = <name of directory>
```

Where` srcdir` specifies the name of the directory the student's source should be contained in.


Running tests
-------------

Each test is stored as a list of commands which should be run. These files always end with `sh`.
They will be run from the directory where `stacscheck` was started from.

There are 4 types of tests. They can be identified by the beginning of their name.

* Scripts starting `build` are *build scripts*. If a build script fails, then the output
  of the script is printed, and no more tests in this directory are run.

* Scripts starting `test` are *standard tests*. If a test script fails, then the output
  of the script is printed.

* Scripts starting `info` are *info scripts*. The output of an info script is always printed.
  This is intended for running style checking tools.

* Scripts starting `prog` are *program scripts*. The output of a program script is automatically
  checked to see if it is the same as a known good input.

  In a directory containing a program script, we do the following:

  * For each file whose name ends in `.out`
    * Is there a file with the same name ending `.in`?
    * If so, then run the program with the input in the `.in` file, and check the output is the same as the `.out` file.
    * If not, then run the program with no input, and check the output is the same as the `.out` file.


For the curious, the comparison of outputs ignores whitespace at the end of lines, and blank lines.

Finally, do this same look (looking for tests) for each subdirectory of the current directory.

Files are always considered in alphabetical order of filename.


Environment variables
---------------------

Sometimes you might want to be able to access the directory the test specification is in, in one of the testing scripts.
Rather than hard-wiring it, the variable `$TESTDIR` will be set to the directory of the currently executing `.sh` file.

There is also a variable `$SCRATCHDIR`, which is set to a temporary directory which will be removed when `stacscheck` is finished.

