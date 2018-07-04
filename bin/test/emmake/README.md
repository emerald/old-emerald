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

## Running the Tests

```
$ bash test.sh
```
