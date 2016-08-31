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
