#! /bin/bash

if [ "$TRAVIS_OS_NAME" == "osx" ]; then
    command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    rvm get stable
fi
./flutter/bin/flutter -v build ios --no-codesign