.. _quickstart:

Quickstart Guide
================

Assuming you have ``stacscheck`` installed, go into the directory of your
practical submission and run:

::

   stacscheck <path to tests>

For example::

   stacscheck /submissions/Course/Practicals/PracticalW04

Command line options
--------------------

**Basic options:**

* ``--help`` : Show all available options
* ``--version`` : Print the version of ``stacscheck``

**Output control:**

* ``-v``, ``--verbose`` : Show more detail, including scripts and inputs for failed tests
* ``-q``, ``--quiet`` : Suppress output for passing tests; info scripts still print their output
* ``--html=FILE`` : Generate an HTML report to FILE with coloured diffs and expandable sections

**Testing options:**

* ``--fail-fast`` : Stop running tests after the first failure
* ``--archive=FILE`` : Test a compressed submission file instead of a directory.
  Supported formats: ``.zip``, ``.tar``, ``.tar.gz``, ``.tgz``, ``.tar.xz``, ``.tar.bz2``
* ``--id=ID`` : Set a submission identifier (shown in HTML output)

Examples
--------

Run tests with HTML output::

   stacscheck tests --html=report.html

Test a compressed submission::

   stacscheck --archive=submission.zip tests

Run in quiet mode, stopping at first failure::

   stacscheck -q --fail-fast tests

HTML reports
------------

The ``--html`` option generates a detailed HTML report that is especially
useful for reviewing test failures:

::

   stacscheck tests --html=report.html

The HTML report includes:

* **Summary header** showing how many tests passed
* **Expandable test sections** — click "expand" to see details for any test
  or use Tab to reach a button, then Enter or Space to expand or collapse it
* **Coloured diff tables** for ``prog`` tests, highlighting exactly what
  differs between expected and actual output
* **Explanation text** from ``.explain`` files (see :ref:`structure`)
* **Colour-coded results**:

  - Green background for passing tests
  - Red background for failing tests
  - Traffic light colours (GREEN/YELLOW/AMBER/RED) for multi-part tests

Program output and failures
---------------------------

If a program leaves output streams open beyond the capture deadline, or reading
its output fails, ``stacscheck`` marks the affected test as failed and explains
why. It preserves the output captured so far and includes the failure in the HTML report. Remaining
tests run as usual, unless ``--fail-fast`` is set or a build failure prevents them
from running.

If your terminal cannot display a character from a program's output,
``stacscheck`` prints ``?`` in its place. Unsupported decorative emojis are
omitted. Test comparisons still use the full captured output, and HTML and JSON
reports retain Unicode characters.

Testing compressed submissions
------------------------------

The ``--archive`` option lets you test a compressed submission file directly,
without manually extracting it first::

   stacscheck --archive=submission.zip tests

``stacscheck`` will:

1. Extract the archive to a temporary directory
2. Look for the ``srcdir`` folder within the extracted contents
3. Run all tests against the extracted submission
4. Clean up the temporary directory when finished

**Supported archive formats:**

* ``.zip`` — ZIP archives
* ``.tar`` — uncompressed tar archives
* ``.tar.gz`` or ``.tgz`` — gzip-compressed tar archives
* ``.tar.bz2`` — bzip2-compressed tar archives
* ``.tar.xz`` — xz-compressed tar archives

This is particularly useful for batch testing multiple student submissions.

If ``stacscheck`` is not installed, read on to find out about
:ref:`Installing stacscheck <installing>`.
