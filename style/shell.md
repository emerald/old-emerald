# The Emerald Shell Scripting Style Guide

In the following, the words "MUST" and "SHOULD" are to be interpreted
as described in [BCP 14](http://tools.ietf.org/html/bcp14) (Bradner,
S., "Key words for use in RFCs to Indicate Requirement Levels", BCP 14
(RFC 2119), March 1997).

## Use `bash`

`bash` MUST be used as the shell scripting language throughout this
codebase.

**Reasoning:** The reasoning is two-fold:

  1. This choice is in accord with the [Google Shell Style
Guide](https://google.github.io/styleguide/shell.xml) ([as of Revision
1.26](https://web.archive.org/web/20190216182133/https://google.github.io/styleguide/shell.xml)).
  2. `bash` seems like the currently most popular shell scripting
language: according to the [TIOBE
Index](https://www.tiobe.com/tiobe-index/) ([as of
2019](https://web.archive.org/web/20190219075007/https://www.tiobe.com/tiobe-index/)),
`bash` is the only shell scripting language among the top-50
programming languages.

## Shebang

All `bash` executables MUST begin with the following shebang:

```
#!/usr/bin/env bash
```

This is used in place of the otherwise common `#!/bin/bash`.

**Reasoning:** `/bin`, by convention, is intended for _essential_
command-line binaries for the system administrator, while `/usr/bin`
is intended for _non-essential_ command-line binaries for the casual
user. On some systems, `bash` may not be regarded as an essential
command-line binary, and may therefore not reside under `/bin`. By
using `env`, we find `bash`, wherever it may be, according to the
user's `PATH` environment variable, and execute that.

## Strict Mode

After the shebang, all `bash` scripts MUST either begin by going into
the following ["strict
mode"](http://redsymbol.net/articles/unofficial-bash-strict-mode/), or
comment on why the script is executed in a less strict mode:

```
set -euo pipefail
```

This does the following:

  1. The script fails as soon as any command fails (`-e`); the
     non-zero exit code gets propagated.
  2. The script fails when an undefined variable is used (`-u`).
  3. A pipeline of commands fails, if any intermediate command fails
     (`-o pipefail`); the non-zero exit code gets propagated.

**Reasoning:** This makes shell scripts more robust and easier to
debug. In particular, it reduces cascading errors, as long as we
regard failing commands and use of non-declared variables as errors.

## Use `printf` rather than `echo`

It [appears](https://unix.stackexchange.com/a/65819) that `printf` has
a more standard behaviour across various shells (and versions of
`bash`!) than `echo`. Furthermore, and perhaps more importantly,
`bash`-style `echo` supports arguments, making it hard to `echo` a
string like `-n`. Hence, if you do not control the input passed to
`echo`, better resort to `printf` instead.

The following function hides the default `echo` to implement the
behaviour you _probably_ expect for `echo`:

```
echo() (
  IFS=" "
  printf '%s\n' "$*"
)
```

Setting IFS to space has the effect that `"$*"` [is expanded
to](https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html)
`"$1 $2 $3..."`.

If you would like to avoid starting a subshell (note parentheses
around the body of the `echo` function above), you can instead define
`echo` as follows:

```
echo() {
  if [ "$#" -gt 0 ]; then
     printf %s "$1"
     shift
  fi
  if [ "$#" -gt 0 ]; then
     printf ' %s' "$@"
  fi
  printf '\n'
}
```
