#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Version 0.2.0

# MIT License

# Copyright (c) 2016 University of St Andrews

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Stacscheck

import os
import subprocess
import re
import sys
import time
from threading import Thread
import difflib
from optparse import OptionParser

# Try importing jinja2, but don't complain if it isn't there
try:
    import jinja2
except ImportError:
    jinja = False
else:
    jinja = True

# The HTML output
JINJAPAGE = """
<!DOCTYPE html>
<html lang="en">
<head>
    <title>{{Practical}} - {{ SubmissionID }} </title>
</head>
<body>
    <table style="width:100%">
    {% for test in Tests %}
    <tr id="test{{ loop.index }}" bgcolor=
    {% if test.pass %} "#BFB" {% else %} "#FBB" {% endif %} >
    <td>{% if test.pass %} Tick {% else %} Cross {% endif %}</td>

        <td> {{ test.name }} </td>
        <td> {{ test.pass }} </td>
        <td> {{ test.returnval }} </td>
    </tr>
    <tr>
    <td colspan="5">
        {% if test.htmldiff %}
        {{ test.htmldiff | safe }}
        {% else %}
        <div display="inline">
        {% for line in  test.stdout.splitlines() %}
        {{line}}<br>
        {% endfor %}
        </div>
        <div display="inline">
        {% for line in  test.stderr.splitlines() %}
        {{line}}<br>
        {% endfor %}
        </div>
        {% endif %}
    </td>
    </tr>
    {% endfor %}
    </table>

</body>
</html>
"""

# Store the base test directory
TESTBASE = None

# Simple function to print out more verbose information if -v is passed
VERBOSE = True
def verbose_print(arg):
    if VERBOSE:
        print(str(arg)+"\n")

# Check function for problems in practical
def warn_print(arg):
    print("Problem in practical: " + str(arg) + "\n")

# Store the results of all tests
testStore = []

# Store if any build ever fails
anyBuildTestFailed = False

# Record that a test was run, printing as approriate
def register_returnval_test(test):
    if test["returnval"] == 0:
        print("pass")
        test["pass"] = True
    else:
        print("fail")
    
    if test["returnval"] != 0 or test.get("alwaysoutput", False):
        if test.get("stderr", False) and test.get("stdout", False):
            print("--- output ---")
            print(test.get("stdout", "").rstrip())
            print("--- error output ---")
            print(test.get("stderr", "").rstrip())
            print("")
        else:
            print("--- output ---")
            print(test.get("stdout", "").rstrip() + test.get("stderr", "").rstrip())        
            print("")
        test["pass"] = False
    testStore.append(test)

# Takes a single string with newlines, and returns a list of lines
# We strip all whitespace, then add a "\n" on the end
# This is to deal with differences in invisible whitespaces
def strip_string(string):
    return [l.rstrip() + "\n" for l in string.split("\n") if l.rstrip() != '']

# Register the result of a test whith a known output
def register_diff_test(test, comparefile):
    verbose_print(test)
    with open(comparefile, 'r') as stream:
        comparelines = stream.read()
    comparelines = strip_string(comparelines)
    userlines = strip_string(test["stdout"])
    test["comparelines"] = comparelines
    test["userlines"] = userlines
    if comparelines == userlines:
        print("pass")
        test["pass"] = True
    else:
        print("fail")
        test["textdiff"] = ["--- expected ---\n"] + comparelines + ["--- submission ---\n" ] + userlines + ["---\n"]
        # test["textdiff"] = list(difflib.unified_diff(userlines,comparelines,"Submission","Reference","",""))
        test["htmldiff"] = difflib.HtmlDiff().make_table(comparelines, userlines, "Submission", "Reference")
        print("".join(test["textdiff"]))
        test["pass"] = False
    testStore.append(test)


# Given a filename of a test, get a nicer, shorter name which
# describes the test. First drop extension, then remove TESTBASE
def nice_name(name):
    return os.path.splitext(name)[0][len(TESTBASE):]


# Read from a stream, recording result in a record
# Caps the total amount read to ~10MB
def read_stream(outdict, name, stream):
    stream_limit = 10000000
    outstr = ''
    while True:
        chunk = stream.read(stream_limit - len(outstr))
        # End of file reached
        if chunk == '':
            outdict[name] = outstr
            return

        # Add chunk
        outstr = outstr + chunk

        if len(outstr) == stream_limit:
            outstr += "\n ... Output truncated\n"
            outdict[name] = outstr
            # Throw away rest of stream
            while stream.read(1024) != '':
                pass
            return


# Run a program, given as a list [prog, arg1, arg2], with
# an optional file to read as stdin, and optional extra environment variables
def run_program(program, stdin, extra_env):
    env_copy = os.environ.copy()

    verbose_print("Running " + " ".join(program))
    if not os.access(program[0], os.X_OK):
        warn_print(program[0] + " is not executable")

    if extra_env is not None:
        for key in extra_env:
            env_copy[key] = extra_env[key]

    try:
        proc = subprocess.Popen(program, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE, close_fds=True, shell=True, env=env_copy)

        retdict = dict()

        thread_err = Thread(target=read_stream, args=(retdict, "stderr", proc.stderr))
        thread_err.start()
        thread_out = Thread(target=read_stream, args=(retdict, "stdout", proc.stdout))
        thread_out.start()

        if stdin is not None:
            stdinfd = open(stdin, "r")
            for line in stdinfd.readlines():
                proc.stdin.write(line)
                time.sleep(1)
            stdinfd.close()
        # Either we have filled stdin, or we are putting nothing in it
        proc.stdin.close()

        thread_err.join()
        thread_out.join()
        proc.wait()

        retdict["returnval"] = proc.returncode
        verbose_print("Tested " + str(program) + ", recieved output: " + str(retdict))
        return retdict
    except OSError:
        warn_print(program[0] + " is broken / not executable")
        return {"returnval": 1, "stdout": "", "stderr": ""}


# Find files in 'directory' matching 'regex'
def files_in_dir_matching_regex(directory, regex):
    files = [os.path.join(directory, f) for f in sorted(os.listdir(directory))
             if re.match(regex, f) and
             os.path.isfile(os.path.join(directory, f))]
    verbose_print("Found " + str(files) + " matching " + str(regex) + " in " + str(directory))
    return files

# Accept a directory name relative to
def run_tests_recursive(testdir):
    verbose_print("Checking in " + testdir)
    # First check for a build*.sh

    extra_env = { "TESTDIR" : testdir }

    buildscripts = files_in_dir_matching_regex(testdir, r'build.*\.sh')
    for buildsh in buildscripts:
        name = nice_name(buildsh)
        sys.stdout.write("** Build " + name + " : ")
        buildshret = run_program([buildsh], None, extra_env)
        buildshret["name"] = name
        buildshret["type"] = "Build"
        register_returnval_test(buildshret)
        if buildshret["returnval"] != 0:
            verbose_print("Exiting early due to failed " + buildsh)
            global anyBuildTestFailed
            anyBuildTestFailed = True
            return

    testscripts = files_in_dir_matching_regex(testdir, r'test.*\.sh')

    for test in testscripts:
        name = nice_name(test)
        sys.stdout.write("** Test " + name + " : ")
        result = run_program([test], None, extra_env)
        result["name"] = name
        result["type"] = "Test"
        register_returnval_test(result)

    infoscripts = files_in_dir_matching_regex(testdir, r'info.*\.sh')

    for info in infoscripts:
        name = nice_name(info)
        sys.stdout.write("** Info " + name + " : ")
        result = run_program([info], None, extra_env)
        result["name"] = name
        result["type"] = "Info"
        result["alwaysoutput"] = True
        register_returnval_test(result)


    progscripts = files_in_dir_matching_regex(testdir, r'prog.*\.sh')

    outfiles = files_in_dir_matching_regex(testdir, r'.*\.out')

    if (len(outfiles) == 0) != (len(progscripts) == 0):
        if len(outfiles) == 0:
            warn_print("Found prog*.sh without *.out files in " + testdir)
        else:
            warn_print("Found *.out files without prog*.sh in " + testdir)
    for progsh in progscripts:
        for out in outfiles:
            infile = out[:-4] + ".in"
            if not os.path.isfile(infile):
                infile = None
            name = nice_name(progsh) + "-" + os.path.basename(out)
            sys.stdout.write("** Comparison test " + name + " :")
            result = run_program([progsh], infile, None)
            result["name"] = name
            register_diff_test(result, out)

    subdirs = [os.path.join(testdir, d) for d in sorted(os.listdir(testdir))
               if os.path.isdir(os.path.join(testdir, d))]

    for d in subdirs:
        run_tests_recursive(d)


##################################################################
# Main program
def run():
    global VERBOSE, TESTBASE
    parser = OptionParser(usage="%prog [options] test1 test2 ... ")
    parser.add_option("--id", dest="subid", default="<unknown>",
                      help="Give identifier for submission")
    parser.add_option("--html", dest="htmlout",
                      help="Produce HTML overview", metavar="FILE")
    parser.add_option("-v", "--verbose",
                      action="store_true", dest="verbose", default=False,
                      help="Output more information during test")

    (options, args) = parser.parse_args()
    if len(args) != 1:
        sys.exit("Must give exactly one test to run")

    if options.htmlout is not None and not jinja:
        sys.exit("Can't output html without the 'jinja2' library. Exiting.\nYou could try 'pip install jinja2'?")

    VERBOSE = options.verbose
    TESTBASE = args[0]

    run_tests_recursive(TESTBASE)

    if len(testStore) == 0:
        print("ERROR: No tests found in '" + TESTBASE + "'")
        sys.exit(1)

    print(str(len([t for t in testStore if t["pass"] ])) + " out of " + str(len(testStore)) + " tests passed")
    if anyBuildTestFailed:
        print("Note: A build step failed, so some tests may have been skipped")

    if options.htmlout is not None:
        env = jinja2.Environment(autoescape=True)
        template = env.from_string(JINJAPAGE)
        with open(options.htmlout, "w") as html:
            html.write(template.render(Practical=TESTBASE,
                                       SubmissionID=options.subid,
                                       Tests=testStore))

if __name__ == "__main__":
    run()
