#!/bin/sh
set -e

xctool -project COBezierTableView.xcodeproj -scheme COBezierTableView build test -sdk iphonesimulator

