How to write tests
===================

Please read 'specification' for a guide to how practicals should be laid out, and 'manual-for-users' to see how to use the tool.

Quick Overview:

* Make a directory which contains the practical. You can nest directories how you like.
* Go into the directory of the student's submission / model answer and run:

    `<stacscheckdirectory>/stacscheck (directory of tests)`

If you add `-v`, you can see some (not nicely formatted) output showing how the tester is going as it runs.


Examples build.sh
-----------------

Here are some example build scripts:

** Basic Java Build **

```
javac *.java
```

```
javac BaseClass.java
```

** Basic C build **

```
make target1
```

Example tests.sh
---------------

Test a program runs cleanly with no arguments:

```
./program
```

Test a program produces the output contained in file out.txt, when run with arguments 1 2 3.

There are many ways to do this in bash. Here is one way, which makes use of SCRATCHDIR and TESTDIR.

```
./program 1 2 3 > "${SCRATCHDIR}/output"
diff -w "${SCRATCHDIR}/output" "${TESTDIR}/out.txt"
```

It is very common to want to run a program, feeding in a particular input, and checking a particular output is given, there is a special shorter format for this, see the 'prog*.sh' discussion above.
