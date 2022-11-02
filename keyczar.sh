#!/usr/bin/env bash

docker run \
  --platform linux/amd64 \
  --rm \
  -v $(pwd)/secrets-keyczar:/home/ubuntu/secrets-keyczar \
  keyczar:latest \
  "$@"
