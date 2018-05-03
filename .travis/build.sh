#! /bin/bash

sudo motion update || echo 'up to date'
./flutter/bin/flutter -v build ios --no-codesign
mkdir Payload
cp -R build/ios/Release-iphoneos/Runner.app Payload
zip -r Payload.zip Payload
mv Payload.zip app.ipa
git add app.ipa