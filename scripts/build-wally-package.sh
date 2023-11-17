#!/bin/sh

set -e

mkdir -p build

rm -rf build/wally

mkdir -p build/wally

cp -r src/ build/wally

./scripts/remove-tests.sh build/wally/src

darklua process build/wally/src build/wally/src

cp default.project.json build/wally
cp wally.toml build/wally
cp LICENSE.txt build/wally

wally package --project-path build/wally --list
