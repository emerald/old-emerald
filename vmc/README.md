# `vmc`

`vmc` appears to be a compiler for an Emerald virtual machine
description.

It is written in C, and it generates C code as output.

This source code comes from the directory [`ubc-latest-src/vmc` in the
`emerald/src-versions` repository, commit ID
`4faee4f29dac9fea92ac10bbeb0b9281f83fdf3a`](https://github.com/emerald/src-versions/tree/4faee4f29dac9fea92ac10bbeb0b9281f83fdf3a/ubc-latest-src).

## Exit code

Unfortunately, `vmc` does not exit with a non-zero exit code on a
syntax error. However, nothing gets written to standard output in case
of success, so if anything _is_ printed it may be regarded as an error
condition.

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
`Interrupts:`, and `Instructions:` must each appear at a beginning of
a line, if present.

Although `vmc` accepts an empty file as a machine description, it does
not generate valid C code for a description without an explicitly
empty set of definitions. (For instance, see how the spurious,
top-level `(null)` is replaced by an empty line in
[`tests/data/empty_defs.patch`](tests/data/empty_defs.patch), as we go
from [an empty file](tests/data/empty.desc), to [a file containing
just `{}`](tests/data/empty_defs.desc).)

`code` is raw C code enclosed in braces.

```
code ::= `{` C-code `}`
```

The C code is allowed to contain braces, but every opening brace must
be matched by a closing brace.

[Test-files](tests) that support the claims above:

| Description | Patch |
|-------------|-------|
| [empty_defs.desc](tests/data/empty_defs.desc) | [empty_defs.patch](tests/data/empty_defs.patch) |
| [empty_states.desc](tests/data/empty_states.desc) | [empty_states.patch](tests/data/empty_states.patch) |
| [empty_ints.desc](tests/data/empty_ints.desc) | [empty_ints.patch](tests/data/empty_ints.patch) |
| [empty_instrs.desc](tests/data/empty_instrs.desc) | [empty_instrs.patch](tests/data/empty_instrs.patch) |
| [all_empty.desc](tests/data/all_empty.desc) | [all_empty.patch](tests/data/all_empty.patch) |
| [defs_with_braces.desc](tests/data/defs_with_braces.desc) | [defs_with_braces.patch](tests/data/defs_with_braces.patch) |

### States

A state has a _name_, _description_, and a _type_. The name and type
will be used as a C identifier, and a C type, respectively. The
description is used inside a C comment.

The `state` non-terminal is defined as follows:

```
state ::= id string string
```

Where `id` must conform to the regular expression
`[A-Za-z_][A-Za-z0-9_]*`, while a `string` must conform to
`"([^\"]|\.)*"`.

This leaves a lot of room for descriptions and types. It is easy to
end up with non-operational or malicious C code, if one is not
careful. This is illustrated in the test-cases below.

[Test-files](tests) that support the claims above:

| Description | Patch |
|-------------|-------|
| [pos_state_name_tests.desc](tests/data/pos_state_name_tests.desc) | [pos_state_name_tests.patch](tests/data/pos_state_name_tests.patch) |
| [pos_state_desc_tests.desc](tests/data/pos_state_desc_tests.desc) | [pos_state_desc_tests.patch](tests/data/pos_state_desc_tests.patch) |
| [pos_state_type_tests.desc](tests/data/pos_state_type_tests.desc) | [pos_state_type_tests.patch](tests/data/pos_state_type_tests.patch) |

### Interrupts

An interrupt has a _name_ and some _code_. A name adhere to the same
constraints as a state name, and code adheres to the same constraints
as the code in the definitions.

The `int` non-terminal is defined as follows:

```
int ::= id code
```

[Test-files](tests) that support the claims above:

| Description | Patch |
|-------------|-------|
| [one_int.desc](tests/data/one_int.desc) | [one_int.patch](tests/data/one_int.patch) |
| [three_ints.desc](tests/data/three_ints.desc) | [three_ints.patch](tests/data/three_ints.patch) |
| [three_ints_no_linebreaks.desc](tests/data/three_ints_no_linebreaks.desc) | [three_ints_no_linebreaks.patch](tests/data/three_ints_no_linebreaks.patch) |

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
