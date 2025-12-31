![CQL running on a-shell](cql-a-shell.png)

ABOUT THIS CODE
---------------

This is a fork of the [CQL](https://www.gadycosteff.com/cql) source distribution "build 9.493," as obtained from this URL: https://www.gadycosteff.com/cql/download.html

**This is a work in progress!**

HOW I HAVE CHANGED THIS CODE
----------------------------

This code includes the changes I've made to get CQL 6.2 to run on an iPhone inside [a-shell](https://holzschu.github.io/a-Shell_iOS/).

To assist with testing, I've also added the `sample.pgn` file that ships with CQL 6.

In order to get CQL to compile, I am using [the latest WASI
SDK](https://github.com/WebAssembly/wasi-sdk/releases), version 29.0 as of this
writing. I have had to remove multithreading/mutexes and all use of C++
exceptions, since neither are supported by WASI's libc++. So far, I've removed
this functionality by strategically commenting it out; see the git history in
this repo for the gory details. In many cases I've indicated my changes with a comment that says "Dan:". My approach has not been elegant or pretty, and
may break some of CQL's functionality; please consider this code **highly
experimental.** Proceed with caution!

Maybe if I have time later I'll come back and do it more cleanly. For now I just wanted to get it working so I can play with CQL on my phone.

BUILDING & RUNNING ON iOS
-------------------------

Here's how I build `cql.wasm` on my Mac. **NOTE:** I have *not* yet succeeded in building it on my phone. If you do, **"patches welcome!"**

### Prerequisites

* dash - POSIX-compliant shell, ships with MacOS
* bmake - portable cross-platform build system, available via Homebrew
* The [WASI SDK](https://github.com/WebAssembly/wasi-sdk/releases)
* Optional (for testing): [wasmtime](https://wasmtime.dev)

### Build

Install bmake, download the [WASI SDK](https://github.com/WebAssembly/wasi-sdk/releases), edit `src/makefile-flags` so the `COMPILE` and `LINK` variables point at the `clang++` and `wasm-ld` contained therein, respectively, then run `bmake`.

*Note*: I call `make` when compiling/linking the CQL sources, since their Makefile assumes GNU make and that's what `make` defaults to on MacOS.

### Test What You Built

**Optional**: If you have [wasmtime](https://wasmtime.dev) installed, you can test the resulting `cql.wasm` with all the CQL file examples in `exalpha/` by running `bmake test` (of the original `exalpha` examples, 4 do not currently work; I have moved them to `exalpha-excludes`, and will move them back if/when I can get them working).

### Deploy to a-shell

Finally, copy `cql.wasm` to the a-shell directory on your iOS device. You should now be able to run it with:

```
wasm cql.wasm [arguments]
```

### Optional: Test What You Built in a-shell

The `make` in a-shell is actually `bmake`, and it also ships with the `wasm` command. If you clone this git repo into your a-shell environment and copy or move `cql.wasm` into its top level, `make test WASM=wasm` should Just Work.

For more about building C++ projects for a-shell, check out [the book](https://bianshen00009.gitbook.io/a-guide-to-a-shell/lets-do-more-for-it/compile-a-simple-command-with-a-shell).
