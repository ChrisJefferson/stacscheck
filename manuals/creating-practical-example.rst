## Practical Creation Tutorial

In this step-by-step tutorial, we will create a new practical.

The practical we will implement will be the following:


    Create a Java class called ``Calculator``. ``Calculator`` should accept print the prompt: ``Enter numbers:``, then read numbers until it reads a `0`. When it reads a `0`, it should print the sum of all numbers which were read, then exit.

    If a non-number is ever read, the program should print `ERROR`, then exit.

In this example we will write the stacscheck, and a model answer, together. You might already have a model answer, or be confident enough to write the stacscheck without a model answer (but that's not recommended, it's easy to make mistakes!)


The first thing every stacscheck test needs is a ``practical.config``, so let's make two directories. One to store our model answer in, called `src` and one to store the stacscheck tests, called `tests`. Then, create a file called `practical.config` inside `tests` which contains:

::

   [info]
   practical = My First Practical
   course = Intro To Java
   srcdir = src

Then, in the directory containing both `src` and `test` try running ``stacscheck``::

    $ stacscheck tests
    Testing Intro To Java My First Practical
    - Looking for submission in a directory called 'src': found in current directory
    ERROR: No tests found in 'tests'
    0 out of 0 tests passed

Success! Well, successfully found no tests, but we are at least on our way. This shows one of the reasons we require ``srcdir``, it means you can run ``stacscheck`` from the directory containing your code, or a directory higher up, or even a directory inside your project and ``stacscheck`` will try to find the root of the project.

Building the code
~~~~~~~~~~~~~~~~~

Now let's actually write a test. First of all, we should build some Java. That's not too hard, we can just write a file called ``build_all.sh`` which contains::

    javac Calculator.java

The important parts of the name are that it ends `sh` (which shows it is a shell script), and that it starts ``build``. ``stacscheck`` assumes that if a build script fails, then it should not run any other tests.

One thing worth considering while writing tests is providing freedoms. Might someone want to write their Calculator in multiple Java files? Perhaps a better build script would be::

    javac *.java


Let's try that out!::

    Testing Intro To Java My First Practical
    - Looking for submission in a directory called 'src': found in current directory
    * BUILD TEST - build_all : fail
    --- submission output ---
    error: file not found: *.java
    Usage: javac <options> <source files>
    use --help for a list of possible options
    ---

    0 out of 1 tests passed
    Building is failing, so some tests were skipped

Hmm... for a real beginner, that might be a confusing message.

One way we can improve the message is by adding ``set -eux``. This enables 3 common features of bash which are often useful for build scripts:

* ``e`` : Stop the script as soon as one line fails
* ``u`` : Stop if we refer to a bash variable (starting ``$``) which doesn't exist
* ``x`` : Print out commands as they are run.

The particularly useful option here is ``x``, which gives us the following output, note the new line at the start of ``submission output``::

    Testing Intro To Java My First Practical
    - Looking for submission in a directory called 'src': found in current directory
    * BUILD TEST - build_all : fail
    --- submission output ---
    + javac '*.java'
    error: file not found: *.java
    Usage: javac <options> <source files>
    use --help for a list of possible options
    ---

    0 out of 1 tests passed
    Building is failing, so some tests were skipped

Of course, what is even better is if we pass the test. Let's add some Java in `Calculator.java`::

    class Calculator
    {
            public static void main(String args[])
            { }
    }

Now, our build tests passes!::

    Testing Intro To Java My First Practical
    - Looking for submission in a directory called 'src': found in current directory
    * BUILD TEST - build_all : pass
    1 out of 1 tests passed

Of course, while the code builds. It still doesn't do what it is supposed to do -- so let's add some tests for it's behaviour.

Testing the code
~~~~~~~~~~~~~~~~

Now let's try testing the program. First we'll make a nice subdirectory in ``tests`` to store our tests. Lets call it ``basic``.

We are now going to use a ``prog`` test. These are special because while they define a program to run, we will *seperately* define an input to give the program, and an output which should be produced.

Our program is fairly simple, make ``prog_run.sh`` (the important bits here are the ``prog`` and ``.sh``, you can put whatever you like inbetween those)::

    java Calculator

Then let's make a simple input file, called ``onenum.in``, containing::

    1 0

Can't get much simpler than this! What output do we expect this to produce. You might think ``1``, but remember we also asked for a prompt! So we will instead get::

    Enter numbers:
    1

Actually, we will get this? Or ``Enter numbers:1``? It depends on if the program puts a new line at the end of the prompt. These kind of fine-tunings often come up when writing tests. Of course, students will hopefully see the issue, and fix their code.

We need an output file. This file should be called ``onenum.out`` (to pair up with ``onenum.in``), and just contain::

    1

Do we need to worry about newlines here? No, because ``stacscheck`` ignores new lines at the end of the output.