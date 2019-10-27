#!/bin/bash

set -e

cd $(dirname $0)
for arch in arm arm64 mips mipsle ppc64 ppc64le ; do
    echo $arch
    GOOS=linux GOARCH=$arch go build -o hello.$arch hello.go
done
