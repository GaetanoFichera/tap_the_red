#! /bin/bash

sudo motion update || echo 'up to date'
./flutter/bin/flutter -v build ios --no-codesign
zip -r build_ios.zip build/ios
git add build_ios.zip