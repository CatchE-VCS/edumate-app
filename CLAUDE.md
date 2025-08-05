# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Edumate is a Flutter-based educational app that provides learning content, contests, skill tracking, and social features. The app uses Firebase for backend services including authentication, Firestore database, and storage.

## Development Commands

### Core Flutter Commands
- `flutter run` - Run the app in development mode
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter clean` - Clean build artifacts
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies

### Testing and Analysis
- `flutter test` - Run widget tests
- `flutter analyze` - Run static analysis (uses flutter_lints rules)
- `dart format .` - Format Dart code

### Firebase Configuration
The app is configured with Firebase and requires proper setup of firebase_options.dart for different platforms.

## Architecture

### State Management
- Uses **Riverpod** (hooks_riverpod) for state management
- Key providers are in `lib/state/` directory
- Authentication state managed through `AuthStateNotifier` in `lib/state/auth/`

### Authentication
- Multi-provider auth system supporting Google, Facebook, and Twitter login
- Authentication logic centralized in `lib/state/auth/backend/authenticator.dart`
- User info storage in `lib/state/user_info/backend/user_info_storage.dart`

### App Structure
- **Pages**: Main screens in `lib/pages/` including home, profile, contests, skills, and reels
- **Themes**: Custom theming system in `lib/themes/` with light/dark theme support
- **Helpers**: Utility classes in `lib/helpers/` for models and controllers
- **Widgets**: Reusable UI components in `lib/widgets/`

### Key Features
- **Educational Content**: Course system with video players (YouTube integration)
- **Contests**: Codeforces integration for programming contests
- **Social Features**: Reel-style content viewing
- **Gamification**: Coin/points system for user engagement
- **Skills Tracking**: User skill assessment and progress tracking

### Firebase Integration
- Authentication via Firebase Auth
- Data storage with Cloud Firestore
- File storage with Firebase Storage
- Push notifications via Firebase Messaging

### Navigation
- Uses named routes defined in main.dart
- Bottom navigation implemented in `lib/widgets/bottom_nav.dart`
- Custom drawer in `lib/widgets/drawer.dart`

## Dependencies Notes
- Video playback: chewie, video_player, youtube_player_flutter
- Image handling: image_picker, image
- UI components: card_swiper, fab_circular_menu, percent_indicator
- Social auth: flutter_facebook_auth, google_sign_in, twitter_login
- Animations: lottie for JSON animations

## Platform Support
The app supports Android, iOS, web, Linux, macOS, and Windows with platform-specific configurations in respective directories.