# `vmc`

`vmc` appears to be a compiler for an Emerald virtual machine
description. `vmc` is a description format compiler written C,
generating C code as output.

This source code comes from the directory [ubc-latest-src/vmc` in the
`emerald/src-versions` repository, commit ID
4faee4f29dac9fea92ac10bbeb0b9281f83fdf3a](https://github.com/emerald/src-versions/tree/4faee4f29dac9fea92ac10bbeb0b9281f83fdf3a/ubc-latest-src).

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
