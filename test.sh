#!/bin/sh
xctool -workspace Example/SHMKit.xcworkspace -scheme Tests -sdk iphonesimulator clean build test ONLY_ACTIVE_ARCH=NO
