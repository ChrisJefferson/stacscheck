Quick Introductory Guide to `stacscheck`
========================================

`stacscheck` is the name of the new automated checker we are using for practical and tutorials.

Getting `stacscheck`
--------------------

On lab machines, and the host servers, `stacscheck` should just be installed. You can check if it is by running
`stacscheck`. You should see the output (possibly with an updated version number)

```
stacscheck 3.2.0
You must give a directory of tests to run!
```

If the machine doesn't have it, you can download it from 
[https://studres.cs.st-andrews.ac.uk/Library/stacscheck/](https://studres.cs.st-andrews.ac.uk/Library/stacscheck/).
You only need the `stacscheck` script. See [installing stacscheck](installing-stacscheck.md) for more guidance
on installing `stacscheck` on your own machine.

`stacscheck` is not currently supported on Windows, only Linux and Macs.


Running `stacscheck`
--------------------

Go into the directory of your practical submission and run:

`stacscheck (path to tests)`

For example:

`stacscheck /studres/CS1002/Practicals/PracticalW04-Tests`

Useful options for `stacscheck`:

*  `--help`      : See all options
*  `--html=FILE` : Output a nice HTML output to FILE
*  `--version`   : Print out version of checker
*  `--verbose`   : Output lots of information about how the testing is progressing (probably too much)

Understanding tests
-------------------

If you want to understand what is being tested, go into the tests directory. Each test is based
on a shell script (which is a series of commands which can be run)

A full specification on how to read the tests is available [here](specification.html).

