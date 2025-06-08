# Kite

A mobile client for [Kite](https://kite.kagi.com) by Kagi.

# Getting Started

- Checkout the repository
- Run `flutter pub get`
- Build and run with `flutter run`

# Development
- The app uses `json_serializable` to parse JSON models. To generate the files run `dart run build_runner build`
- To generate the localizations, run `flutter gen-l10n`

# Deployment

For iOS:
- Increase the version and build numbers in `pubspec.yaml`
- For iOS build:
    - Run: `flutter build ipa`
    - Use Xcode or Transporter to upload to the App Store
- For Android build:
    - Run `flutter build appbundle`
    - Upload the build to the Play Store 

# Tests
- Run `flutter test`

# User testing
Use the Testflight link to beta test the application: https://testflight.apple.com/join/whwSKG8Z

# Known Limitations
- No caching of web resources
- No tablet optimized layout

# Suggestions for Improvement
- Improve article reader layout
- Optimize article reader rendering

# License
This project is licensed under the MIT License – see the [LICENSE](LICENSE.md) file for details.