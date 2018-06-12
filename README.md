[![Build Status](https://travis-ci.org/emerald/emerald.svg?branch=master)](https://travis-ci.org/emerald/emerald)

## Requirements

  * `lex` and `yacc` (not `bison`).

  * 32-bit version of `glibc`.

  * 32-bit version of `libl.so` (usually part of the development package for `flex`).

## Layout

  * [vm](vm) — The Emerald VM
  * [vmc](vmc) — The Emerald VM description compiler
  * [ccalls](ccalls) — Special "primitive" operations in Emerald
