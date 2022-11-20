Installing stacscheck
=====================

If you are using a department mahine you don’t need to install
``stacscheck``, you should just be able to run it with ``stacscheck``.

To check if ``stacscheck`` is installed, just try running it, you should
see some output like this:

::

   $ stacscheck
   << fill in >>

You might have a different version.

If you want to install stacscheck on your own computer, skip to TODO
installing on your own machine XX.

If you want to run stacscheck on your own computer, the best idea is to
get the same version as is running on lab machines.

Also, always make sure your practical runs on a lab machine or host
server before submitting!

If you want to install it yourself, on your own machine, read on. Note
that this requires some basic knowledge of the Unix command line
(changing directory, copying files), which I’m not going to cover here.

Firstly, ``stacscheck`` does not work on Windows without some extra
work. The easiest option is to install the “Windows Subsystem for Linux”
(known as WSL) – look in the Windows App store for “Ubuntu”. Once you’ve
installed that, you will have a fully functional Linux, and can run
``stacscheck`` there. In fact, ``stacscheck`` was developed in WSL on
Windows!

``stacscheck`` is a single script which you can copy to another
computer. You can get releases from
``www.github.com/ChrisJefferson/stacscheck``. On a computer which
already has ``stacscheck`` installed type ``which stacscheck`` to find
out where it is located – you can just copy it from there!

You will need to have ``python3`` installed on your machine to run
``stacscheck``. Many OSes come with it installed. If ``python3`` doesn’t
work on the command line, first look into install ``python3``. Your
operating system’s package manager will definately have ``python3``! If
you installed WSL on Windows, remember you want to install ``python3``
**inside the Linux install**, not as a standard Windows program.

If you now have ``stacscheck`` and ``python3``, you should be able to
run:

::

   $ python3 stacscheck
   << to fill in >>

If you want to be able to just run ``stacscheck``, you will have to:

(a) Mark ``stacscheck`` as executable, by running
    ``chmod +x stacscheck``.
(b) Move the ``stacscheck`` executable to somewhere in your ``PATH`` –
    but we aren’t going to teach about that here!
