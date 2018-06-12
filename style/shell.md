# Shell Style Guide

`bash` is used as the shell scripting language throughout this
codebase. This choice is in accord with the [Google Shell Style
Guide](https://google.github.io/styleguide/shell.xml), and `bash` does
currently seem like the most frequently used shell scripting language.

## Shebang

All `bash` executables begin with the following shebang:

```
#!/usr/bin/env bash
```

This is used in place of the otherwise common `#!/bin/bash`.

The reason is that `/bin`, by convention, is intended for _essential_
command-line binaries for the system administrator, while `/usr/bin`
is intended for _non-essential_ command-line binaries for the casual
user. On some systems, `bash` may not be regarded as an essential
command-line binary, and may therefore not reside under `/bin`. Using
`env`, we find `bash`, wherever it may be, according to the user's
`PATH` environment variable, and execute that.

## Strict Mode

All `bash` scripts begin by going into a "strict mode":

```
set -euo pipefail
```

This does the following:

  1. The script fails as soon as any command fails (`-e`); the
     non-zero exit code gets propagated.
  2. The script fails when an undefined variable is used (`-u`).
  3. A pipeline of commands fails, if any intermediate command fails
     (`-o pipefail`); the non-zero exit code gets propagated.
