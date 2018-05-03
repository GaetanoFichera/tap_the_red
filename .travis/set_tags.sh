#!/usr/bin/env bash
git config --local user.name "GaetanoFichera"
git config --local user.email "gaetano.fichera93@gmail.com"
git tag "$(date +'%Y%m%d%H%M%S')-$(git log --format=%h -1)"