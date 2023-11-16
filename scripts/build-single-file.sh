#!/bin/sh

set -e

mkdir -p build

rm -f build/symbol-luau.lua

darklua process --config .darklua-bundle.json src/init.lua build/symbol-luau.lua
