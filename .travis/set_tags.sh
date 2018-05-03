#!/usr/bin/env bash

zip -rj iphoneos.zip build/ios/iphoneos

BRANCH="master"

# Are we on the right branch?
if [ "$TRAVIS_BRANCH" = "$BRANCH" ]; then

  # Is this not a Pull Request?
  if [ "$TRAVIS_PULL_REQUEST" = false ]; then

    # Is this not a build which was triggered by setting a new tag?
    if [ -z "$TRAVIS_TAG" ]; then
      echo -e "Starting to tag commit.\n"

      git config --global user.email "gaetano.fichera93@gmail.com"
      git config --global user.name "GaetanoFichera"

      echo -e "Git Config Done.\n"

      # Add tag and push to master.
      git tag -a v${TRAVIS_BUILD_NUMBER} -m "Travis build $TRAVIS_BUILD_NUMBER pushed a tag."
      git push origin --tags
      git fetch origin

      cd build/ios/iphoneos/
      ls

      echo -e "Done magic with tags.\n"
    fi
  fi
fi