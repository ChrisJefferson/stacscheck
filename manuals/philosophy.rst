The Philosophy of Stacscheck
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Stacscheck is designed to automate testing in the lightest way possible. There were four founding principles -- although I am not claiming these have all been met!



* **Transparency**: It should be as clear how the tester is running a particular test.
* **Extensibility**: The tester should be easy to extend with new types of tests.
* **Simplicity**: Writing tests (particularly of common existing types) should be as simple as possible.
* **Fallback**: The tester should be as light as possible -- the more complex a system, and the more pieces it has, the easier it is for it to break.

Several of these requirements are in conflict -- most particularly **Extensibility** and **Simplicity**.

After considering various options, we decided to base Stacscheck on *shell scripts*. While shell scripts have many annoying features, they are a general and powerful way of running any program on Unix.

The use of shell scripts does mean that Stacscheck does not run on Windows (unless you install a Linux later, like WSL). However achieving any useful **Extensibility** and **Simplicity** while supporting Unix and Windows would be extremely difficult (maybe impossible!)