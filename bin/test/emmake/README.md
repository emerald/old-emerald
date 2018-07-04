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
something where we can temporarily remain insensitive to, and record
the exit codes of `emmake` sub-processes.

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

All subdirectories of this directory are orchestrated test-cases for
[`test.sh`](test.sh). However, [`test.sh`](test.sh) will only regard a
subdirectory as a test-case if it has a file `quiet.txt` or
`verbose.txt`. These files correspond to the expected cumulative
stdout and stderr output from `emmake` for this directory.

All test-case subdirectories also contain an `exitcode.txt` containing
the expected exit code form `emmake` for that directory.

The following is a more detailed overview of the subdirectories:

## Common Makefiles

### Tests Where Common Makefiles Are Present

  * [`libMacroMf`](./libMacroMf)
  * [`libCcallsMf`](./libCcallsMf)
  * [`libArchMacroMf`](./libArchMacroMf)
  * [`libCcallsAndArchMacroMf`](./libCcallsAndArchMacroMf)
  * [`libMacroAndArchMacroMf`](./libMacroAndArchMacroMf)
  * [`libMacroAndCcallsMf`](./libMacroAndCcallsMf)
  * [`libAllMf`](./libAllMf)

### Tests Where Common Makefiles Are Absent

  * [`withmakefile`](./withmakefile)
  * [`withMakefile`](./withMakefile)
  * [`withmakefile_depend`](./withmakefile_depend)
  * [`withmakefile_Depend`](./withmakefile_Depend)
  * [`withMakefile_depend`](./withMakefile_depend)
  * [`withMakefile_Depend`](./withMakefile_Depend)

## Negative Tests

It is clearly a mistake if `emmake` is called in a directory where
there is no Makefile:

  * [`nomakefile`](./nomakefile)

`emmake` will only append `makefile.depend`, if the `makefile` has
matching casing. That is, `makefile.depend` will not be appended if
the accompanying file is called `Makefile`, and `Makefile.depnd` will
not be appended if the accompanying file is called `makefile`. I find
it debatable whether this adequate behaviour.

  * [`withmakefile_Depend`](./withmakefile_Depend)
  * [`withMakefile_depend`](./withMakefile_depend)

## Running the Tests

```
$ bash test.sh
```
