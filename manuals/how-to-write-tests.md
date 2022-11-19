## Advice for writing tests

This section contains some advice for writing tests. Some of this advice will be language specific. Also, quite a lot of this advice will be general advice for writing good "unix" shell scripts.

I am going to assume before reading this you have already read the section on how a stacscheck test is designed.


General advice
==============

* `stacscheck` always runs tests with `bash`, so you don't have to start tests with `#!/usr/bin/env bash` -- but you can if you like.

* Consider using some `set` at the top of your script to set some `bash` options. Some useful options are:
    - `set -e`: Make your script stop as soon as any command doesn't work. Usually once one command has failed you want to exit immediately anyway. This also means any failed command means the whole file is labelled as failing.
        - If you are using lots of pipes (|), you can add `set -o pipefail`, which will make a test fail if any program in any part of a pipe fails.
    - `set -u`: If you refer to any variable without a value, the script stops. This catches spelling mistakes like `${TESTDR}` instead of `${TESTDIR}`.
    - `set -x`:  Makes the script print out each command before executing it. This is particularly useful when debugging, but it doesn't hurt to leave it in the finished version if you want people to see what commands are being executed.

    - You can combine all these together, with `set -eux`.

* Write shell variables like `${TESTDIR}` instead of `$TESTDIR`. These behave the same, except it is clearer where the shell variable ends and the next command begins.
* Make use of `"` to deal with spaces in filenames. Spaces in filenames are generally annoying to handle, and it's good to discourage people from using them, but if you write things like `"${TESTDIR}/myfile"`, then spaces in `${TESTDIR}` will be handled correctly.

### Build tests

Build tests tend to be short. Some examples include:

** Basic Java Building **

```
javac *.java
```

or just build one file

```
javac BaseClass.java
```

Or, if you want to build every Java file in every subdirectory, and also the current directory, you can use `globstar` which makes `**` gain the power to search all directories (after turning it on with `shopt -s globstar`)

```
shopt -s globstar
javac **/*.java
```


** Basic C building **

C programs are often built with `make`:

```
make target1
```


** Generic building **

Once students are more confident with scripting, you can always let them write their own build script! then just make a test which looks like

```
./build.sh
```

Which will run `./build.sh` from their source directory.

If you want to test the program has been successfully built, you can run something like this:

```
set -eux
./build.sh
[[ -f prog ]]
```

Where `[[ -f prog ]]` checks if there is now a file called `prog`. Note you need all the spaces here, `[[-f prog]]` won't work!

### Writing a 'prog' script

A `prog` script is one of the most common types of tests.

It consists of 3 (or 2 sometimes) parts:

1) A script which runs the submitted program, with a name that starts `prog`. This can be very short (just the executable name in many cases)

```
./program
```

or

```
java MyProgram
```

A file ending `.out` which contains the output of the program

```
Hello Chris!
```

An, optionally, a file ending `.in` with the input for the the program

```
Chris

```


The program is run, the input is fed in, and the output is compared to the `.out`.

This type of test isn't, strictly, necessary -- next we will cover `test` scripts, and you could completely emulate the behaviour of a `prog` script with a `test` script. However, it's easy to get wrong!


### 'test' scripts

A 'test' script is just executed, and the return value is checked. For example, lets consider a program where we want to give it the arguments "1 2 3", then check the output against a known output.

We could write **(NOTE: DO NOT WRITE THIS!)** the following, using the variables `${SCRATCHDIR}` (to get a temp directory) and `${TESTDIR}` (to get the directory the test is stored in).


```
./program 1 2 3 > "${SCRATCHDIR}/output"
diff -w "${SCRATCHDIR}/output" "${TESTDIR}/out.txt"
```

Why is this a bad idea? The biggest problem is that if `program` enters an infinite loop, then we will fill up `${SCRATCHDIR}` -- many computers get very upset if the temporary directory gets filled up, requiring rebooting the computer. In general, be careful ever storing the output of a program in a file.

Now, we could use some advanced bash-foo to handle this, for example we could write this:

```
diff -w <(./program 1 2 3) "${TESTDIR}/out.txt"
```
Where `<(...)` redirects the output of a program straight into another command without a temporary file -- but we still couldn't nicely render the `diff` output in the HTML, like we do for a `prog` script.