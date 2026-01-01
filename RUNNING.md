RUN CQL ON iOS
--------------

### Deploy to a-shell

Copy `cql.wasm` from the [release tarball](https://github.com/lamech/cql/releases), or from where you [built it yourself](README.md#building-it-yourself), to the a-shell directory on your iOS device. You should now be able to run it with:

```
wasm cql.wasm [arguments]
```

### Optional: Test cql.wasm in a-shell

If you clone [this git repo](https://github.com/lamech/cql) into your a-shell environment and copy or move `cql.wasm` into its top level, `make test WASM=wasm` should run the included `sample.pgn` through all the examples under `exalpha/`.
