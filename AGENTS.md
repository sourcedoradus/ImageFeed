# ImageFeed

ImageFeed is a native **iOS** application (Yandex Practicum training project). It is a photo
feed backed by the Unsplash API: the user signs in through Unsplash OAuth2 in a web view, then
browses a list of photos, opens a single photo, likes photos, and views their profile.

The app is built with **UIKit + Storyboards** (`Main.storyboard`, `LaunchScreen.storyboard`),
`Assets.xcassets`, and an `Info.plist`. There is a single Xcode application target, `ImageFeed`,
defined in `ImageFeed.xcodeproj`. There are no third-party dependency managers
(no CocoaPods / Swift Package Manager / Carthage) and no automated test targets.

## Cursor Cloud specific instructions

**Platform requirement: this project can only be built, run, linted, or tested on macOS with
Xcode. It cannot be built or run on the Linux Cloud Agent VM.**

Why: the Xcode project targets iOS (`SDKROOT = iphoneos`, `IPHONEOS_DEPLOYMENT_TARGET = 13.0`,
`productType = com.apple.product-type.application`) and 9 of the 13 Swift files `import UIKit`
(the rest use `Foundation`). Building and running require Apple's iOS SDK, the `xcodebuild`/`xcrun`
toolchain, and the iOS Simulator — all of which are macOS-only. The Cloud Agent VM runs Linux
(Ubuntu), where `swift`, `swiftc`, `xcodebuild`, and `xcrun` are absent and cannot be installed to
target iOS. There are therefore **no Linux dependencies to install**, so the environment update
script is intentionally a no-op.

Even the four `Foundation`-only files (`Constants.swift`, `OAuth2Service.swift`,
`OAuth2TokenStorage.swift`, `AuthScreen/URLSession+data.swift`) will not compile as-is with the
open-source Swift Linux toolchain, because on Linux `URLSession` lives in the `FoundationNetworking`
module and would require an added `import FoundationNetworking` (a source change this repo does not
have).

### On macOS (where development actually happens)

Open `ImageFeed.xcodeproj` in Xcode, or use the command line from the repo root:

- Build for a simulator:
  `xcodebuild -project ImageFeed.xcodeproj -scheme ImageFeed -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 15' build`
- Run: launch the `ImageFeed` scheme on an iOS Simulator from Xcode (Cmd+R).
- Lint: no linter is configured in the repo (no SwiftLint config). Xcode's compiler warnings act as
  the lint baseline; treat a clean build as the lint check.
- Tests: there is no test target, so there are no automated tests to run.

### Secrets / auth (Unsplash)

`ImageFeed/Constants.swift` currently hard-codes Unsplash API `accessKey`/`secretKey`. Signing in
end-to-end requires a valid Unsplash app credential and a real Unsplash account. This only matters
when running the app on macOS/Simulator.
