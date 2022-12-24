.. _installing:

Installing stacscheck
=====================

If you are using a department machine, you don’t need to install
`stacscheck`, you should be able to run it with `stacscheck`.

You can try running `stacscheck` to check if it is installed. You should
see some output like this:

::

   $ stacscheck
   Basic usage: stacscheck <testdir>
   To see all options: stacscheck --help

Remember that many courses requires that `stacscheck` is run on a lab
machine before submission, so if you install `stacscheck` on your own machine,
check the submission instructions for any practicals!

`stacscheck` is designed to run on Linux and Mac OS and will not work on Windows without a little extra work. The easiest option is to install the “Windows Subsystem for Linux”
(known as WSL) –- look in the Windows App store for “Ubuntu”. Once you have installed WSL you will have a fully functional Linux, and can run
`stacscheck` there. In fact, `stacscheck` was developed in WSL on Windows!


`stacscheck` has only a single requirement -- ``python3``. Many systems come with ``python3`` installed, so first try just running `python3`` and see if it works. If it doesn't, try looking at the instructions on the `Python Wiki <https://wiki.python.org/moin/BeginnersGuide/Download>`_ . Remember that if you installed WSL on Windows, you want to follow the instructions for Ubuntu, not Windows!

Once you have installed `python3`, the easiest way to install `stacscheck` is pip::
   
   python3 -m pip install stacscheck

If this complains that you do not have root access, then you can instead try::

   python3 -m pip install --user stacscheck

As `stacscheck` is a single script, you can copy it from a computer that already has `stacscheck` installed. In this case, you may not have libraries that provide access to more advanced `stacscheck` features (such as coloured or HTML output).

If you copy `stacscheck` from another computer, you will have to:

* Mark `stacscheck` as executable by running ``chmod +x stacscheck``.
* (Optionally) move the `stacscheck` executable to somewhere in your ``PATH`` -- but we aren’t going to teach about that here!
