#! /bin/bash

if [ "$TRAVIS_OS_NAME" == "osx" ]; then
    command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    rvm get stable
fi
pip2 install six
brew update
brew install --HEAD libimobiledevice
brew install ideviceinstaller
brew install ios-deploy
git clone https://github.com/flutter/flutter.git -b alpha --depth 1