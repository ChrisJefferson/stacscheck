.. _installing:

Installing stacscheck
=====================

If you are using a department machine, you don't need to install
``stacscheck`` — you should be able to run it directly.

You can try running ``stacscheck`` to check if it is installed. You should
see some output like this::

   $ stacscheck
   stacscheck 3.3.0
   You must give a directory of tests to run!

Remember that many courses require that ``stacscheck`` is run on a lab
machine before submission, so if you install ``stacscheck`` on your own machine,
check the submission instructions for any practicals!

``stacscheck`` is designed to run on Linux and macOS. It will not work on
Windows without additional setup. The easiest option is to install the
"Windows Subsystem for Linux" (WSL) — look in the Microsoft Store for "Ubuntu".
Once you have installed WSL, you will have a fully functional Linux environment
and can run ``stacscheck`` there.

``stacscheck`` requires only Python 3 (no additional packages). Many systems
come with Python 3 installed. Try running ``python3 --version`` to check.
If Python is not installed, see the instructions on the
`Python Wiki <https://wiki.python.org/moin/BeginnersGuide/Download>`_.
If you installed WSL on Windows, follow the instructions for Ubuntu, not Windows.

Downloading stacscheck
----------------------

``stacscheck`` is a single Python script with no external dependencies.
Download it from GitHub:

https://github.com/ChrisJefferson/stacscheck

You can either clone the repository or download just the ``stacscheck`` file directly.

After downloading, you will need to:

* Mark ``stacscheck`` as executable by running ``chmod +x stacscheck``
* (Optionally) move ``stacscheck`` to somewhere in your ``PATH`` (e.g., ``~/bin`` or ``/usr/local/bin``)
