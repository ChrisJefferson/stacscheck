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

* ``-v``, ``--verbose`` : Show all commands that ``stacscheck`` runs and their inputs
* ``-q``, ``--quiet`` : Suppress output for passing tests (only show failures)
* ``--html=FILE`` : Generate an HTML report to FILE with colored diffs and expandable sections

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

Understanding the output
------------------------

``stacscheck`` uses symbols to indicate test results:

* ✅ **pass** — The test succeeded
* ❌ **fail** — The test failed
* 💡 **INFO** — An informational test (output is always shown)
* 🎉 — Celebration when all tests pass!

If ``stacscheck`` is not installed, read on to find out about
:ref:`Installing stacscheck <installing>`.