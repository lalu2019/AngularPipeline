#!/bin/bash

set -e

echo "🔁 Checking out code (if using Git)..."
git status

echo "📦 Installing dependencies..."
npm ci

echo "🔍 Linting code..."
npm run lint || { echo "❌ Lint failed"; exit 1; }

echo "🧪 Running tests..."
npm test || { echo "❌ Tests failed"; exit 1; }

echo "📱 Building Android..."
cd android
./gradlew assembleRelease || { echo "❌ Android build failed"; exit 1; }
cd ..

# if [[ "$OSTYPE" == "darwin"* ]]; then
#   echo "🍏 Building iOS..."
#   cd ios
#   pod install
#   xcodebuild -workspace YourApp.xcworkspace -scheme YourApp -sdk iphoneos -configuration Release || { echo "❌ iOS build failed"; exit 1; }
#   cd ..
# fi

echo "✅ Build complete!"
