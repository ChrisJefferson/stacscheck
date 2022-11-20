This section assumes you already know how to use ``stacscheck``, and
want to either understand how ``stacscheck`` tests are designed.

practical.config
~~~~~~~~~~~~~~~~

The only requirement for a ``stacscheck`` test is a directory which
contains a file called ``practical.config``.

The file ``practical.config`` provides some brief configuration. It must
contain the following:

::

   [info]
   practical = <practical name>
   course = <course name>
   srcdir = <name of directory>

Where ``practical`` can ``course`` can be any string, and ``srcdir``
specifies the name of the directory the source of the practical should
be contained in. The reason we require a ``srcdir`` is it makes it easy
to figure out what the base directory of the submission is.

``practical.config`` can optionally contain a ``[version]`` section, if
there is a required version:

::

   [version]
   required = 3.1.0

This is only used to produce more useful error messages to users with
out-of-date versions of ``stacscheck``

The design of tests
~~~~~~~~~~~~~~~~~~~

A ``stacscheck`` test is fundamentally just a list of commands to
execute. ``stacscheck`` itself does not understand any particular
programming language (like Java, C or Javascript), or any particular
testing framework (like jUnit or pytest).

``stacscheck`` is designed under the general idea that we run a series
of commands and each command can optionally:

-  Feed some input to a program, as if it was typed at the keyboard
-  Check the return value of a program to see if it succeeded or failed
-  Check the output of the program and compare it to a known \``good’’
   output.

If a test fits this general framework, then it will work well with
``stacscheck``. Things which do not fit well in this framework (for
example testing if a GUI behaves correctly) will be harder to implement.

Types of test
~~~~~~~~~~~~~

Each individual test is stored as a *shell script*. These files always
end with ``sh``. We will begin by describing the types of tests, then
later some best practices to follow when writing them.

There are four different types of tests. The type of a effects how
``stacscheck`` runs the script, and interprets the output. The beginning
of the name of a script identifies it’s type:

-  Names starting ``build`` are *build scripts*. This type of test
   succeeds if the return value of the script is zero. If a build script
   fails, then the output of the script is printed, and no more tests in
   this directory (or any subdirectories) are run.

-  Names starting ``info`` are *info scripts*. The output of an info
   script is always printed. This is intended for running things like
   style checking tools, where you always want users to see the output.

-  Names starting ``test`` are *standard tests*. This type of test
   succeeds if the return value of the script is zero. If a test script
   fails, then the output of the script is printed.

-  Names starting ``prog`` are *program scripts*. This differs from the
   other formats in that other files are required. The ``prog`` is
   executed with an (optional) input file, and the output is compared to
   an output file. The test passes if the output of the script is the
   same as the known output (what does “the same” mean? It’s a little
   complicated, see TODO link to comparing outputs

   The exact behaviour of ``stacscheck`` when it sees a file starting
   ``prog`` is the following:

   -  For each file in the directory whose name ends in ``.out``

      -  Is there a file with the same name ending ``.in``?
      -  If so, then run the program with the input in the ``.in`` file,
         and check the output is the same as the ``.out`` file.
      -  If not, then run the program with no input, and check the
         output is the same as the ``.out`` file.

The overall execution loop of ``stacscheck`` is, starting from the root
directory is the following. Note that whenever there are multiple files
to run or directories to consider, they are always considered in
alphabetical order.

TODO: verify

-  Run each ``build`` script. If any fails, then return immediatly,
   running no more scripts or checking any subdirectories.
-  Run each ``info`` script, printing any output
-  Run each ``test`` script, printing output if any fails
-  For each ``prog`` script, for each ``name.out`` file, run the
   ``prog`` with ``name.in`` as input (if present), then compare against
   ``name.out``, failing the test if the output differs from
   ``name.out``
-  For each sub-directory of the current directory, run this loop again
   in that subdirectory.

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

``stacscheck`` sets some unix environment variables which any test
script can access.

-  ``$TESTDIR``: The directory of the currently executing script
-  ``$TESTBASEDIR``: The directory containing ``practical.config``
-  ``$SCRATCHDIR``: A temporary directory which will be automatically
   cleaned up when ``stacscheck`` finishes.
