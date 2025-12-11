#!/bin/sh

set -eu

# References:
# <https://www.reddit.com/r/FlutterDev/comments/1piz2g8/comment/nt9qibl/>
# <https://docs.flutter.dev/install/archive>
# sudo apt install git unzip clang cmake ninja-build pkg-config libgtk-3-dev libstdc++-12-dev mesa-utils

git clone --depth 1 --branch 3.38.4 https://github.com/flutter/flutter.git ~/flutter-sdk
echo 'export PATH="~/flutter-sdk/bin:$PATH"' > ~/.profile
~/flutter-sdk/bin/flutter update-packages
~/flutter-sdk/bin/flutter precache
~/flutter-sdk/bin/flutter --version
~/flutter-sdk/bin/flutter doctor -v
