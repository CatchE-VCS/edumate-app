// Flutter imports
import 'package:edumate/core/localization/locale_service.dart';
import 'package:flutter/material.dart';

// Third-party package imports
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';

// Core imports
import 'package:edumate/firebase_options.dart';
import 'package:edumate/core/localization/app_localizations.dart';

// Presentation imports
import 'package:edumate/presentation/pages/coins.dart';
import 'package:edumate/presentation/pages/contest_page.dart';
import 'package:edumate/presentation/pages/new_home.dart';
import 'package:edumate/presentation/pages/profile_page.dart';
import 'package:edumate/presentation/pages/reel/home_page.dart';
import 'package:edumate/presentation/pages/skill_page.dart';
import 'package:edumate/presentation/pages/splash_page.dart';
import 'package:edumate/presentation/themes/themes.dart';

// State management imports
import 'package:edumate/src/settings/settings_controller.dart';
import 'package:edumate/src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize settings
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  
  runApp(
    ProviderScope(
      child: EdumateApp(settingsController: settingsController),
    ),
  );
}

class EdumateApp extends StatelessWidget {
  const EdumateApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Edumate - Learn & Grow',
        debugShowCheckedModeBanner: false,
        
        // Theme configuration
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        
        // Internationalization
        localizationsDelegates: const [
          AppLocalizations.delegate,
          // Add other delegates as needed
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        localeResolutionCallback: LocaleService.localeResolutionCallback,
        
        // Initial route00000000
        initialRoute: '/',
        home: const SplashPage(),
        
        // Route configuration
        routes: _buildRoutes(),
        
        // Error handling
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0), // Prevent text scaling issues
            ),
            child: child!,
          );
        },
      ),
    );
  }

  /// Build application routes
  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/': (context) => const SplashPage(),
      '/home': (context) => const NewHomePage(),
      '/skill': (context) => const SkillScreen(),
      '/profile': (context) => const ProfilePage(),
      '/reels': (context) => const HomeScreen(),
      '/coins': (context) => const Coins(),
      '/contest': (context) => const ContestPage(),
      // Add more routes as needed
    };
  }
}

/// Application configuration constants
class AppConfig {
  static const String appName = 'Edumate';
  static const String version = '1.0.0';
  static const bool isDebugMode = bool.fromEnvironment('dart.vm.product') == false;
  
  // Feature flags
  static const bool enableAnalytics = true;
  static const bool enablePerformanceMonitoring = true;
  static const bool enableCrashReporting = true;
  
  // API configuration
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.edumate.com',
  );
  
  static const Duration networkTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
}

/// Global error handler
void setupErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log error to crashlytics or other service
    if (AppConfig.isDebugMode) {
      FlutterError.presentError(details);
    }
  };
}