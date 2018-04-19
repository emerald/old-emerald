# gitc - Git Containers - v0.2

Git Containers intends to help you journal the process by which you
generate a change in your Git repository, supplementing your
line-by-line diffs with concise, reproducible edit commands.

To achieve this, gitc will require you to commit the binaries used to
generate the changes, and help you log the arguments you passed to
those binaries to generate the changes.

"But wait, committing binaries to Git is a cardinal sin?" - No, it is
not; it merely renders the built-in diff command against those files
useless. However, in gitc, binaries are never meant to change anyway.

## Current Implementation

The current implementation uses a [busybox](https://busybox.net/), and
provides a command-recording shell. By committing the busybox (and
surrounding shell scripts) to your repository, you can log your
changes merely by committing the command log.

If you would like to manually reproduce the changes, you can use your
variants of the software, and just run the commands in the log, or you
can start up `gitc-shell.sh` and reproduce the results using the
provided busybox.

I recommend running `gitc-shell.sh` as follows:

```
$ PATH="$(pwd)/.gitc/bin:$PATH" gitc-shell.sh
```

## Usage

Make sure that the repository is _clean_: No non-staged or untracked
files.

Execute the following to get into a busybox shell, which will also
record your commands, and commit them to Git when done:

```
$ PATH="$(pwd)/.gitc/bin:$PATH" gitc-record.sh
```

You will get to modify the commit message before `gitc-record.sh`
commits on your behalf.

**NB!** The shell you get is a little rough, and things go bad if your
commands fail. Press Ctrl+D when done.
