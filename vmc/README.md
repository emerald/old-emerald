# `vmc`

`vmc` appears to be a compiler for an Emerald virtual machine
description.

It is written in C, and it generates C code as output.

This source code comes from the directory [`ubc-latest-src/vmc` in the
`emerald/src-versions` repository, commit ID
`4faee4f29dac9fea92ac10bbeb0b9281f83fdf3a`](https://github.com/emerald/src-versions/tree/4faee4f29dac9fea92ac10bbeb0b9281f83fdf3a/ubc-latest-src).

## Syntax

A VM description consists of an optional set of definitions (C code),
followed by some optional state, interrupt, and instruction
declarations:

```
machine ::= odefs ostates oints oinstrs
odefs ::=
        | code
ostates ::=
          | `^State:` state*
oints ::=
        | `^Interrupts:` int*
oinstrs ::=
          | `^Instructions:` instr*
```

The special character `^` indicates that the terminals `State:`,
`Interrupts:`, and `Instructions:` must each appear at a begining of a
line, if present.

Although `vmc` accepts an empty file as a machine description, it does
not generate valid C code for a description without an explicitly
empty set of definitoins. (For instance, see how the spurious,
top-level `(null)` is replaced by an empty line in
[`tests/data/empty_defs.patch`](tests/data/empty_defs.patch), as we go
from [an empty file](tests/data/empty.desc), to [a file containing
just `{}`](tests/data/empty_defs.desc).)

## Building

There exists a Docker-image where this builds.

You can fire up Docker as follows:

```
$ docker run \
    --interactive --tty --rm \
    --volume "$(pwd)/:/home/docker/" \
    ${image}
```

Where `${image}` is the following:

* `portoleks/emerald-vmc-builder:v0.1`

(More images coming soon.)

Once you land in the shell inside the Docker image, simply run `make`.
