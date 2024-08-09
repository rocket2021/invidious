#!/usr/bin/env bash

cd build

PATCHES=../patches-enabled/*.patch

for p in $PATCHES; do
	echo "applying ${p}..."
	git apply --check $p && git apply $p
done

