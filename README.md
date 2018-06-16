[![Build Status](https://travis-ci.org/emerald/emerald.svg?branch=master)](https://travis-ci.org/emerald/emerald)

## Requirements

  * `lex` and `yacc` (not `bison`).

  * 32-bit version of `glibc`.

  * 32-bit version of `libl.so` (usually part of the development package for `flex`).

### `bash`

`bash` is used as the shell scripting language throughout this
codebase. This choice is in accord with the [Google Shell Style
Guide](https://google.github.io/styleguide/shell.xml), and `bash` does
currently seem like the most frequently used shell scripting language.

See also the project's [Shell Style Guide](style/shell.md).

## Layout

  * [vm](vm) — The Emerald VM
  * [vmc](vmc) — The Emerald VM description compiler
  * [ccalls](ccalls) — Special "primitive" operations in Emerald
  * [EC](EC) — The Emerald Compiler (written in Emerald)
