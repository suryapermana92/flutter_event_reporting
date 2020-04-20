#!/bin/sh

## Clean the build folder
echo "Cleaning build cache"
rm -rf build
flutter clean

echo "Running lint task"
flutter analyze

echo "Running build task | Android"
flutter build apk -t lib/main_dev.dart

echo "Running build task | iOS"
flutter build ios -t lib/main_dev.dart