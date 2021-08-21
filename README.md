# pomd4c

`pomd4c` is a very simplistic doc generator for C projects.
It's small and hacky. It's licensed under the [MIT license](./COPYING).

> :information_source: for build information/mechanics/examples, see
> [the API docs](./API.md).


The rules are:
 - Comments are output verbatim (with [minor exceptions](./API.md#this-is-how-it-works)).
 - C definitions/declarations following comments are wrapped in C code fences.

That's it!

You can test it out like so:

```bash
gcc ./pomd4c.c -o ./pomd4c \
    && ./pomd4c ./pomd4c.c > ./API.md
```

## Syntax

#### Input like this:

```C
/* A comment with one '*' is ignored. */

/** A comment with two '*' is a doc comment. */

/** A comment with two '*' followed by a C def documents that def, e.g.: */
static int my_int = 53;
```

#### Produces output like this:

<pre>
A comment with two '*' is a doc comment.


A comment with two '*' followed by a C def documents that def, e.g.:

```C
static int my_int = 53;
```
</pre>

#### Which looks like this:

A comment with two '*' is a doc comment.


A comment with two '*' followed by a C def documents that def, e.g.:

```C
static int my_int = 53;
```

