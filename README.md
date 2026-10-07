# CodeAlpha_Quote_of_the_day

A minimal Flutter app that displays a random quote on launch and on demand.

Built as **Task 2 — Random Quote Generator** for the CodeAlpha App Development internship.

## Features

- Shows a random quote every time the app opens
- "New Quote" button fetches a different quote on each tap
- Guard prevents the same quote appearing twice in a row
- Smooth fade transition between quotes
- Clean, minimal Material 3 UI
- Author name displayed clearly beneath each quote

## Tech

- Flutter (Android-only)
- Dart
- Material 3
- No third-party packages, no network calls, no API keys

## How to run

bash:

flutter pub get
flutter run


Project structure
text
lib/
  screens/
    home_screen.dart  
  main.dart
