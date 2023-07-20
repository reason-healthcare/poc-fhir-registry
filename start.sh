#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p $SCRIPT_DIR/storage

docker run -it --rm --name verdaccio \
  -p 4873:4873 \
  -v $SCRIPT_DIR/conf:/verdaccio/conf \
  -v $SCRIPT_DIR/storage:/verdaccio/storage \
  verdaccio/verdaccio

