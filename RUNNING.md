RUN CQL ON iOS
--------------

### Deploy to a-shell

Copy `cql.wasm` from the [release tarball](https://github.com/lamech/cql/releases) to the a-shell directory on your iOS device. You should now be able to run it with:

```
wasm cql.wasm [arguments]
```

### Optional: Test What You Built in a-shell

The `make` in a-shell is actually `bmake`, and it also ships with the `wasm` command. If you clone [this git repo](https://github.com/lamech/cql) into your a-shell environment and copy or move `cql.wasm` into its top level, `make test WASM=wasm` should run the included `sample.pgn` through all the examples under `exalpha/`.
