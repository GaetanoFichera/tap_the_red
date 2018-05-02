#!/bin/bash -e

pip install six
brew update
brew install --HEAD libimobiledevice
brew install ideviceinstaller
brew install ios-deploy
git clone https://github.com/flutter/flutter.git -b alpha --depth 1