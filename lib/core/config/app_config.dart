import 'package:flutter/foundation.dart';

/// Application configuration and constants
class AppConfig {
  // App Information
  static const String appName = 'EduMate';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Educational companion app for learning and skill development';
  
  // Build Configuration
  static const bool isDebug = kDebugMode;
  static const bool isProfile = kProfileMode;
  static const bool isRelease = kReleaseMode;
  
  // API Configuration
  static const String baseApiUrl = 'https://kontests.net/api/v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  
  // Cache Configuration
  static const Duration cacheExpiration = Duration(minutes: 10);
  static const int maxCacheEntries = 100;
  
  // UI Configuration
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 4.0;
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // Responsive Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;
  
  // Feature Flags
  static const bool enableAnalytics = !kDebugMode;
  static const bool enableCrashReporting = !kDebugMode;
  static const bool enablePerformanceMonitoring = kDebugMode;
  static const bool enableDebugTools = kDebugMode;
  
  // Content Configuration
  static const int maxSearchResults = 50;
  static const int itemsPerPage = 20;
  static const Duration searchDebounce = Duration(milliseconds: 500);
  
  // Security Configuration
  static const bool requireBiometricAuth = false;
  static const Duration sessionTimeout = Duration(hours: 24);
  
  // Accessibility Configuration
  static const double minTouchTargetSize = 44.0;
  static const double maxFontScale = 2.0;
  static const double minFontScale = 0.8;
  
  // Get environment-specific configuration
  static String get environment {
    if (isDebug) return 'development';
    if (isProfile) return 'staging';
    return 'production';
  }
  
  // Get API base URL with environment suffix
  static String get apiBaseUrl {
    switch (environment) {
      case 'development':
        return '$baseApiUrl/dev';
      case 'staging':
        return '$baseApiUrl/staging';
      default:
        return baseApiUrl;
    }
  }
  
  // Logging configuration
  static bool get enableVerboseLogging => isDebug;
  static bool get enableNetworkLogging => isDebug;
  static bool get enablePerformanceLogging => isDebug || isProfile;
  
  // Get app display name with environment suffix
  static String get displayName {
    if (isDebug) return '$appName (Debug)';
    if (isProfile) return '$appName (Staging)';
    return appName;
  }
}