# A Test-Suite for `emmake`

## Background

`emmake` is a shell-script wrapper for `make`. It calls into `make`,
but overrides its Makefile-searching behaviour under certain
conditions. In particular, if Emerald-specific Makefiles are present,
these are included using the `-f` option of `make`.

Unfortunately, providing this option also means that `make` _will not_
conduct its regular search for Makefiles in the working directory.
`emmake` must therefore mimic this behaviour on behalf of `make`
(**sigh**).

`emmake` originally uses `/bin/sh` in its shebang. This violated the
style guide for shell scripts in this repository (all shell scripts
must be written in `bash`).

Although `bash` ought to behave as `/bin/sh`, there is no guarantee of
this. This seemed like a fine opportunity to declare a small
test-suite for `emmake` to also completely understand how it works
before making any changes.

## Analysis

Since `emmake` is a variant of `make`, to test it, we need to
orchestrate directories with adequate Makefiles. Although it would be
best to do this automatically, in a property-based manner, it would
perhaps suffice to devise them manually — `emmake` is a fairly short
utility (71 lines of shell code), so an exhaustive collection
test-cases is probably within reach.

It is also probably a good idea to have both some positive, and some
negative tests, checking for adequate success and failure of `emmake`.
This means that the test execution engine should be written in
something where we can temporarily remain insensitive to the exit
codes of `emmake` sub-processes.

Other than the exit codes, the output from, and effect of calling
`emmake`should be compared to some expected output and effect. This
can be done by collecting the expected output and effects in a
dedicated directory, and commit that directory to Git. Then, the test
can run atop the same directory, and if the test causes changes that
Git can spot, then the test should fail.

# Design

Since `emmake` calls `make`, it is a poor idea to declare the test
execution engine in a `Makefile`. This would result in recursive calls
to make, which results in absolute directory paths (where the
Makefiles are located) being written to stdout. Hence, the test
execution engine is written in `bash`.

## Running the Tests

```
$ bash test.sh
```
