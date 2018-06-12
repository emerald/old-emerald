# Makefile Style Guide

## Variables

Variables should be [_simply
expanded_](https://www.gnu.org/software/make/manual/html_node/Flavors.html)
(declared using `:=`), unless there is a clear need for _recursively
expanded_ variables (declared using `=`).
