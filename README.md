# pomd4c

`pomd4c` is a lightweight doc generator for _small, simple,_ projects.

It's licensed under the [MIT license](./COPYING).

> :information_source: for a complete example, see the  [the API docs](./API.md), which are
> generated by `pomd4c` from its own source.
>
> (for a real-world example, see the [libbsat API docs](https://github.com/andrew-canaday/libbsat/blob/main/API.md) or
> [example docs](https://github.com/andrew-canaday/libbsat/blob/main/example/README.md))


The rules are:
 - Special comments are output verbatim (with [minor exceptions](./API.md#this-is-how-it-works)).
 - C definitions/declarations following comments are wrapped in C code fences.
 - Optionally, you can adjust the output using a [postprocessing script](./examples/postproc/).

That's it!

You can test it out like so:

```bash
gcc ./pomd4c.c -o ./pomd4c \
    && ./pomd4c ./pomd4c.c > ./API.md
```

<details><summary>:point_left: Example</summary>

### input.c

```C
/** #### Doc Comment Header!
 *
 * Doc comments start with `'/'`, `'*'`, `'*'`.
 *
 * Anything inside is emitted verbatim.
 * For example, here's a list:
 *
 *  - regular ol'
 *  - markdown list
 *
 * > :warning: **NOTE**: _This message is important!_
 *
 * ----
 *
 * You get the idea.
 *
 * Anything that _immediately follows_ a doc comment is
 * wrapped in C code fences, like so:
 */
int my_func(uint32_t flags, const char* msg);

```

### output.md

#### Doc Comment Header!

Doc comments start with `'/'`, `'*'`, `'*'`.

Anything inside is emitted verbatim.
For example, here's a list:

 - regular ol'
 - markdown list

> :warning: **NOTE**: _This message is important!_

----

You get the idea.

Anything that _immediately follows_ a doc comment is
wrapped in C code fences, like so:

```C
int my_func(uint32_t flags, const char* msg);
```


</details>

## Usage

```
pomd4c 0.9.0
USAGE: ./pomd4c [OPTIONS] FILE1 [FILE2...FILEN]

OPTIONS:
 -h	Usage info (this)
 -v	Verbosity (more times == more verbose)
 -p	Post-process output script (default: none)
 -e	Specify a postprocessor env parameter (multiple ok)
   	(e.g.: pomd4c -e 'my_key=my_value')

POSTPROCESSING

  By default, pomd4c simply buffers the contents of special comments
  and any C entitity that follows immediately afterwards. Output is
  direct to STDOUT.

  To facilitate additional formatting and file handling, pomd4c can
  optionally offload the last step — formatting and file writing —
  to an auxiliary process, e.g.:

    $ pomd4c -p /path/to/my/script ./my_source.c

  The process receives two arguments, "COMMENT" and "BODY": they are
  paths to temp files containing the comment data and the subsequent
  C entity (if present). STDOUT and STDERR are left open (mind your
  STDOUT if you're leveraging redirects!). Parameters and metadata
  are provided through the env. C entities are NOT wrapped in code
  fences.


POSTPROCESS ENV

  pomd4c provides some limited metadata to postprocessing scripts, by
  way of env vars with a "POMD4C_" prefix, e.g.:

      POMD4C_VERSION: the current pomd4c version...
      POMD4C_SOURCE:  the path (absolute) to the current source


ENVIRONMENT

  Some pomd4c behavior can be further customized via env vars:

    NAME:              DESRIPTION:                         DEFAULT:
    POMD4C_SKIP_COLS   Number of comment columns to skip   3
```
