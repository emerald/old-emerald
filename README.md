[![Build Status](https://travis-ci.org/emerald/old-emerald.svg?branch=master)](https://travis-ci.org/emerald/old-emerald)

## Requirements

  * `bash`

  * `lex` and `yacc` (not `bison`).

  * `make`

  * 32-bit version of `glibc`.

  * 32-bit version of `libl.so` (usually part of the development package for `flex`).

## Layout

  * [vm](vm) — The Emerald VM
  * [vmc](vmc) — The Emerald VM description compiler
  * [ccalls](ccalls) — Special "primitive" operations in Emerald
  * [EC](EC) — The Emerald Compiler (written in Emerald)

## Style Guides

  * [Shell Style Guide](style/shell.md)
  * [Makefiles](style/make.md)
