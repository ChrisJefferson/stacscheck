Installing stacscheck
=====================

Firstly, if you are on a lab machine, or host server, you don't need to install `stacscheck`, you should
just be able to run it with `stacscheck`. Also, always make sure your practical runs on a lab machine or host
server before submitting!

If you want to install it yourself, on your own machine, read on. Note that `stacscheck` is not supported on windows.

You can always get the latest version of `stacscheck` from 
[https://studres.cs.st-andrews.ac.uk/Library/StacsCheck/](https://studres.cs.st-andrews.ac.uk/Library/StacsCheck/).
You only need the script `stacscheck` from this location.

After you download it, you need to (as with any program you download on linux or mac) run the tester with python, or
mark `stacscheck` executable.

The easier route is to run with python. Just type `python ~/Downloads/stacscheck` (assuming you downloaded into `~/Downloads`).
This should run the tester, and now just type `python ~/Downloads/stacscheck` wherever you would previously just type `stacscheck`.


Or, to avoid having to type `python` all the time, we can mark the program as executable. Here is how to do that, assuming
again the program is in `~/Downloads`:

```
chmod +x ~/Downloads/stacscheck
```

Now we can run it by typing `~/Downloads/stacscheck`. You can also move this into any directory you like.


