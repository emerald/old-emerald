# `genccdef` tests

[`genccdef`](../../genccdef) analyses given header files for calls to
the `CCALLS` macro, extracts parts of those calls, and turns them into
new macro definitions in a structured way.  The purpose of this
test-suite is to check that when we make changes to
[`genccdef`](../../genccdef), we do not modify its original behaviour.

The header files in this directory stem from the top-level `ccalls`
directory at commit
[`1fc3c2d`](https://github.com/emerald/emerald/tree/1fc3c2dfa02021d4e081423ea5642979ca3ecbb4/ccalls).
The test-suite uses [`genccdef`](../../genccdef) to generate
[`lib/ccdef`](lib/ccdef), and compares it to the one stored in Git.

To run the test, execute [`make test`](Makefile) in this directory.
