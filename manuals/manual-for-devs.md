Quickstart / Manual
===================

Please read 'practical-specification' for a guide to how practicals should be laid out.


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

There are many ways to do this in bash. Here is one way, which makes use of SCRATCH_DIR and TEST_DIR.

```
./program 1 2 3 > "${SCRATCH_DIR}/output"
diff -w "${SCRATCH_DIR}/output" "${TEST_DIR}/out.txt"
```

It is very common to want to run a program, feeding in a particular input, and checking a particular output is given, there is a special shorter format for this, see the 'prog*.sh' discussion above.
