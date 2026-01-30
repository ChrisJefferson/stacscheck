.. _structure:

The Structure of a Stacscheck Test
==================================

This Section assumes you already know how to use `stacscheck` and
want to understand how `stacscheck` tests are designed. You
might read this Section because you want to understand existing tests or because
you want to create new tests.


practical.config
~~~~~~~~~~~~~~~~

The only requirement for a `stacscheck` test is a directory which
contains a file called ``practical.config``.

The file ``practical.config`` provides some brief configuration. It must
contain the following:

::

   [info]
   practical = <practical name>
   course = <course name>
   srcdir = <name of directory>

Where ``practical`` can ``course`` can be any string, and ``srcdir``
specifies the name of the directory which contains the code to be tested.
. The reason ``srcdir`` is required is to make sure we start running
tests from the correct place.

``practical.config`` can optionally contain a ``timeout`` setting to limit
how long each test can run:

::

   [info]
   practical = My Practical
   course = CS101
   srcdir = src
   timeout = 30

The ``timeout`` value is in seconds. If not specified, the default is 60 seconds.
When a test exceeds the timeout, it is terminated and marked as failed.

``practical.config`` can optionally contain a ``[version]`` section, if
there is a required minimum version of ``stacscheck``:

::

   [version]
   required = 3.1.0

The version is only used to provide a helpful error message to users with
an out-of-date version of ``stacscheck``.

The design of tests
~~~~~~~~~~~~~~~~~~~

A `stacscheck` test is a shell script -- a list of commands to
execute. `stacscheck` does not understand any particular
programming language (like Java, C or Javascript), or any specific
testing framework (like jUnit or pytest).

`stacscheck` is designed under the general idea that we run a series
of commands, where each command can optionally:

-  Feed some input to a program being checked, as if it was typed at the keyboard
-  Check the return value of a program, to see if it succeeded or failed
-  Check the output of the program and compare it to a known "good"
   output.

If a test fits this general framework, it will work well with
`stacscheck`. On the other hand, things that do not fit well in this framework (for
example testing GUIs) will be harder to implement.

Types of test
~~~~~~~~~~~~~

Each test is stored as a *shell script*. These files always
end with ``sh``. In this section we will describe the different types of
tests, see :ref:`Advice for writing tests <advice>` for some suggestions
and best practices for writing good tests.

There are four different types of tests. The type of a test effects how
`stacscheck` runs it, and interprets the output. The beginning
of the name of a script identifies its type:

-  Names starting ``build`` are *build scripts*. This type of test
   succeeds if the return value of the script is zero. If a build script
   fails, the script's output is printed, and no more tests are run in
   this directory (or any subdirectories).

-  Names starting ``info`` are *info scripts*. The output of an info
   script is always printed. ``info`` tests are intended for running things like
   style-checking tools, where you always want users to see the output.

-  Names starting ``test`` are *standard tests*. This type of test
   succeeds if the return value of the script is zero. If a test script
   fails, then the script's output is printed.

-  Names starting ``prog`` are *program scripts*. ``prog`` tests differ from the
   other formats, as other files are required. The ``prog`` is
   executed with an (optional) input file. The test passes if the output is equal
   to a pre-specified output. What does “the same” mean? It’s a little
   complicated, see :ref:`how outputs are compared <outputs_compared>`.

   The exact behavior of `stacscheck` when it sees a file starting
   ``prog`` is the following:

   -  For each file in the directory whose name ends in ``.out``

      -  Is there a file with the same name ending ``.in``?
      -  If so, then run the program with the input in the ``.in`` file,
         and check the output is the same as the ``.out`` file.
      -  If not, then run the program with no input, and check the
         output is the same as the ``.out`` file.

A ``stacscheck`` test is a directory of tests, possibly with tests also
stored in subdirectories. ``stacscheck`` executes tests using the following
algorithm:

-  Run each ``build`` script. If any build fails, then return immediately,
   running no more scripts or checking any subdirectories.
-  Run each ``info`` script, printing any output
-  Run each ``test`` script, printing output if any fails
-  For each ``prog`` script, for each ``name.out`` file, run the
   ``prog`` with ``name.in`` as input (if present), then compare against 
   ``name.out``, failing the test if the output differs from 
   ``name.out``
-  For each sub-directory of the current directory, run this loop again
   in that subdirectory.

Whenever there are multiple files to run or sub-directories to consider, they 
are always run in alphabetical order.


.. _outputs_compared:

How outputs are compared
^^^^^^^^^^^^^^^^^^^^^^^^

Outputs are compared to be “visually the same”. This means the following
differences are ignored:

-  Spaces or tabs at the end of a line
-  Blank lines at the end of the output
-  Replacing spaces with tabs, or vice versa (as long as they display
   the same on a terminal)

While the following are counted as different:

-  Extra spaces at the start of lines, or in the middle of a line
-  More or less blank lines in the middle of the output

If you are having trouble spotting the difference between two outputs,
consider using the ``--html`` output, which will show a coloured diff.

Environment variables
~~~~~~~~~~~~~~~~~~~~~

``stacscheck`` sets some Unix environment variables which any test
script can access:

-  ``$TESTDIR``: The directory of the currently executing script.
-  ``$TESTROOTDIR``: The directory containing ``practical.config``.
-  ``$SCRATCHDIR``: A temporary directory which is automatically
   cleaned up after each test completes.

Example usage in a test script::

   # Copy a data file from the test directory
   cp "${TESTDIR}/testdata.txt" .

   # Use scratch space for temporary files
   ./myprogram > "${SCRATCHDIR}/output.txt"

Explanation files
~~~~~~~~~~~~~~~~~

You can provide helpful explanations for tests by creating ``.explain`` files.
These files contain text that helps users understand what a test is checking
and how to fix failures.

To create an explanation file, use the same name as the test script but with
a ``.explain`` extension instead of ``.sh``:

-  ``test-memory.sh`` → ``test-memory.explain``
-  ``build-compile.sh`` → ``build-compile.explain``
-  ``prog-run.sh`` → ``prog-run.explain``

For ``prog`` tests, you can also create output-specific explanations. If you
have ``prog-run.sh`` with ``example.out``, you can create:

-  ``prog-run.explain`` — shown for all outputs from this prog script
-  ``example.explain`` — shown only for the ``example.out`` comparison

If both exist, both are displayed (script-level first, then output-specific).

**Display behavior:**

-  **Terminal output**: Explanations are shown only when a test fails,
   appearing after the failure output.
-  **HTML output**: Explanations are always shown for every test,
   regardless of pass or fail.

**Example explanation file** (``test-memory.explain``)::

   This test checks that your program correctly frees all allocated memory.

   Common issues:
   - Forgetting to call free() before returning
   - Not freeing memory in error handling paths
   - Memory leaks in loops

   Try running your program with valgrind to find leaks:
     valgrind --leak-check=full ./yourprogram
