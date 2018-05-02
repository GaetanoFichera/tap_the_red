#! /bin/bash

sudo motion update || echo 'up to date'
./flutter/bin/flutter -v build ios --no-codesign