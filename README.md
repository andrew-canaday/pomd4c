# pomd4c

`pomd4c` is a very simplistic doc generator for C projects.

It's small (one file) and hacky (...).
It's intended for projects that are small and simple.
It's licensed under the [MIT license](./COPYING).

> :information_source: for a complete example, see the  [the API docs](./API.md), which are
> generated by `pomd4c` from its own source.


The rules are:
 - Comments are output verbatim (with [minor exceptions](./API.md#this-is-how-it-works)).
 - C definitions/declarations following comments are wrapped in C code fences.

That's it!

You can test it out like so:

```bash
gcc ./pomd4c.c -o ./pomd4c \
    && ./pomd4c ./pomd4c.c > ./API.md
```

## Example

### Input C:

```C
/** ### this is a doc comment!
 *
 * Anything in here is emitted verbatim.
 * For example, here's a list:
 *
 *  - regular ol'
 *  - markdown list
 *
 * ##### Example
 *
 * ```C
 * puts("Including nested code fences!");
 * ```
 *
 * > :warning: **NOTE**: _This message is important!_
 *
 * Anything that immediately follows a doc comment is
 * wrapped in C code fences, like so:
 */
int my_func(uint32_t flags, const char* msg);
```

#### Output markdown:

### this is a doc comment!

Anything in here is emitted verbatim.
For example, here's a list:

 - regular ol'
 - markdown list

##### Example

```C
puts("Including nested code fences!");
```

> :warning: **NOTE**: _This message is important!_

Anything that immediately follows a doc comment is
wrapped in C code fences, like so:

```C
int my_func(uint32_t flags, const char* msg);
```

