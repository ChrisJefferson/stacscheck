3.2.1 -> 3.3.0
==============

* Fixed some HTML output issues
* Added new test type 'MULTI' that accepts a Json array containing Json Objects for each test result
* Added 'trafficlight' result type (not just pass/fail) for MULTI test type 
* Updated student_overview and HTML for multi & trafficlight.

3.0.0 -> 3.1.0
==============

* Fix bug in running builds in subdirectories in tests in correct order
* Improve some warning messages
* Add SCRATCHDIR, a directory which is cleaned up after every test

2.2.4 -> 3.0.0
==============

* Significant improvements to HTML output
* Add --archive flag for running compressed files directly
* Require Python 3
* Allow running subdirectories of tests


2.2.3 -> 2.2.4
==============

* Handle long lines even better

2.2.2 -> 2.2.3
==============

* Handle very long inputs better
* Reduce time sleeping between lines
* Always ignore __MACOSX directory
* Improve output for whole class

2.2.1 -> 2.2.2
==============

* Improve formatting of html output (include all messages)

2.2.0 -> 2.2.1
==============

* Add anchors to HTML output
* Fix 'submission' and 'reference' being wrong way around in HTML output

2.1.0 -> 2.2.0
==============

* Handle UTF-8 and binary data correctly.

2.0.2 -> 2.1.0
==============

* Add '--tryharder' in all-students.sh
* Add 'clean-files.sh' scripts
* Add '.txt' to text output for running-all-students
* Always output a HTML and JSON file, even if student submission is badly broken
* Add stderr to end of stdout for diff tests, rather than swallowing it
* Greatly improved error messages

2.0.0 -> 2.0.2
==============

* First main release
* Minor output tweaks

1.0.2 -> 2.0.0
==============
* BREAKING : practical.config now required
* Make JSON output neater

1.0.1 -> 1.0.2
==============
* Add JSON output

1.0.0 -> 1.0.1
==============

* Catch more file-based exceptions

0.3.0 -> 1.0.0
==============

* Try to catch more errors from unreadable files
* Don't require executable flag on test scripts
* Improve HTML output
* Handle unable to find source directory


0.2.0 -> 0.3.0
==============

* Improve HTML outputting
* Rename stacscheck.py -> stacscheck
* Reduce time between line outputs (1 sec -> 0.1 sec)
* Fix bug with 'INFO' options always counting as failure


0.1.0 -> 0.2.0
==============

* Fix TESTDIR variable
* Handle program wanting less than all the input file
* Skip hidden files


0.0.1 -> 0.1.0
==============

* Sleep for 1 second after each input line, to avoid problems with EasyIn.
* Stop outputting diffs by default.
* Output name of test before running it, in case it takes a long time.
* Don't ignore whitespace changes at the start of lines
* Only require 'jinja2' when outputting HTML
* Add an overview to end of test run
