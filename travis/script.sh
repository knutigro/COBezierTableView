#!/bin/sh
set -e

xctool -project COBezierTableViewDemo/COBezierTableViewDemo.xcodeproj -scheme COBezierTableViewDemo build test -sdk iphonesimulator

