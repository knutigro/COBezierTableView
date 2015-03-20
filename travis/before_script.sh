#!/bin/sh
set -e

brew unlink xctool
brew update
brew install xctool