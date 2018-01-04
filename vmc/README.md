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
