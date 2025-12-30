#!/usr/bin/sh

for i in $(ls exalpha/);
  do
  b="${i##*/}"; # basename with extension
  wasm cql.wasm -i sample.pgn -o "testoutput/${b%.*}-out.pgn" exalpha/${i};
done
