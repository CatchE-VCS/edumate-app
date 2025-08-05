import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:edumate/utils/internationalization/app_localizations.dart';

/// Service for managing app locale and language settings
class LocaleService {
  static const String _localePrefsKey = 'selected_locale';
  
  /// Get the current system locale
  static Locale get systemLocale {
    final systemLanguage = ui.PlatformDispatcher.instance.locale.languageCode;
    final systemCountry = ui.PlatformDispatcher.instance.locale.countryCode;
    
    // Check if system locale is supported
    final supportedLocale = AppLocalizations.supportedLocales.firstWhere(
      (locale) => locale.languageCode == systemLanguage,
      orElse: () => const Locale('en', 'US'),
    );
    
    return Locale(supportedLocale.languageCode, systemCountry ?? supportedLocale.countryCode);
  }
  
  /// Get default locale (system locale if supported, otherwise English)
  static Locale get defaultLocale {
    final systemLang = ui.PlatformDispatcher.instance.locale.languageCode;
    
    final isSupported = AppLocalizations.supportedLocales
        .any((locale) => locale.languageCode == systemLang);
    
    if (isSupported) {
      return systemLocale;
    }
    
    return const Locale('en', 'US');
  }
  
  /// Get all supported locales with their display names
  static Map<Locale, LocaleDisplayInfo> get supportedLocalesWithNames {
    return {
      const Locale('en', 'US'): const LocaleDisplayInfo(
        displayName: 'English',
        nativeName: 'English',
        flag: '🇺🇸',
      ),
      const Locale('es', 'ES'): const LocaleDisplayInfo(
        displayName: 'Spanish',
        nativeName: 'Español',
        flag: '🇪🇸',
      ),
      const Locale('fr', 'FR'): const LocaleDisplayInfo(
        displayName: 'French',
        nativeName: 'Français',
        flag: '🇫🇷',
      ),
      const Locale('de', 'DE'): const LocaleDisplayInfo(
        displayName: 'German',
        nativeName: 'Deutsch',
        flag: '🇩🇪',
      ),
      const Locale('ja', 'JP'): const LocaleDisplayInfo(
        displayName: 'Japanese',
        nativeName: '日本語',
        flag: '🇯🇵',
      ),
      const Locale('zh', 'CN'): const LocaleDisplayInfo(
        displayName: 'Chinese',
        nativeName: '中文',
        flag: '🇨🇳',
      ),
      const Locale('ar', 'SA'): const LocaleDisplayInfo(
        displayName: 'Arabic',
        nativeName: 'العربية',
        flag: '🇸🇦',
      ),
      const Locale('hi', 'IN'): const LocaleDisplayInfo(
        displayName: 'Hindi',
        nativeName: 'हिन्दी',
        flag: '🇮🇳',
      ),
    };
  }
  
  /// Check if a locale is RTL (Right-to-Left)
  static bool isRTL(Locale locale) {
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(locale.languageCode);
  }
  
  /// Get text direction for a locale
  static TextDirection getTextDirection(Locale locale) {
    return isRTL(locale) ? TextDirection.rtl : TextDirection.ltr;
  }
  
  /// Format locale for display (e.g., "English (US)")
  static String formatLocaleForDisplay(Locale locale) {
    final info = supportedLocalesWithNames[locale];
    if (info != null) {
      final country = locale.countryCode?.isNotEmpty == true 
          ? ' (${locale.countryCode})' 
          : '';
      return '${info.flag} ${info.displayName}$country';
    }
    
    return '${locale.languageCode.toUpperCase()}${locale.countryCode != null ? ' (${locale.countryCode})' : ''}';
  }
  
  /// Get native name for a locale
  static String getNativeName(Locale locale) {
    final info = supportedLocalesWithNames[locale];
    return info?.nativeName ?? locale.languageCode.toUpperCase();
  }
  
  /// Get flag emoji for a locale
  static String getFlagEmoji(Locale locale) {
    final info = supportedLocalesWithNames[locale];
    return info?.flag ?? '🌐';
  }
  
  /// Parse locale from string (e.g., "en_US" or "en-US")
  static Locale? parseLocaleString(String localeString) {
    try {
      final parts = localeString.split(RegExp(r'[_-]'));
      if (parts.isEmpty) return null;
      
      final languageCode = parts[0].toLowerCase();
      final countryCode = parts.length > 1 ? parts[1].toUpperCase() : null;
      
      return Locale(languageCode, countryCode);
    } catch (e) {
      return null;
    }
  }
  
  /// Convert locale to string representation
  static String localeToString(Locale locale) {
    return locale.countryCode != null 
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;
  }
  
  /// Get the best matching supported locale for a given locale
  static Locale getBestMatchingLocale(Locale requestedLocale) {
    // First try exact match
    for (final supportedLocale in AppLocalizations.supportedLocales) {
      if (supportedLocale == requestedLocale) {
        return supportedLocale;
      }
    }
    
    // Then try language code match
    for (final supportedLocale in AppLocalizations.supportedLocales) {
      if (supportedLocale.languageCode == requestedLocale.languageCode) {
        return supportedLocale;
      }
    }
    
    // Fall back to English
    return const Locale('en', 'US');
  }
  
  /// Get locale resolution callback for MaterialApp
  static Locale localeResolutionCallback(
    List<Locale>? locales,
    Iterable<Locale> supportedLocales,
  ) {
    if (locales == null || locales.isEmpty) {
      return defaultLocale;
    }
    
    for (final locale in locales) {
      final bestMatch = getBestMatchingLocale(locale);
      if (AppLocalizations.supportedLocales.contains(bestMatch)) {
        return bestMatch;
      }
    }
    
    return defaultLocale;
  }
  
  /// Get appropriate date format for locale
  static String getDateFormat(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'MM/dd/yyyy';
      case 'de':
      case 'fr':
        return 'dd.MM.yyyy';
      case 'ja':
      case 'zh':
        return 'yyyy/MM/dd';
      case 'ar':
      case 'hi':
        return 'dd/MM/yyyy';
      default:
        return 'MM/dd/yyyy';
    }
  }
  
  /// Get appropriate time format for locale
  static String getTimeFormat(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'h:mm a'; // 12-hour format
      default:
        return 'HH:mm'; // 24-hour format
    }
  }
  
  /// Get appropriate number format for locale
  static String formatNumber(num number, Locale locale) {
    // This is a simplified implementation
    // In a real app, you might want to use intl package for proper formatting
    switch (locale.languageCode) {
      case 'de':
      case 'fr':
        return number.toString().replaceAll('.', ',');
      default:
        return number.toString();
    }
  }
  
  /// Get appropriate currency symbol for locale
  static String getCurrencySymbol(Locale locale) {
    switch (locale.countryCode) {
      case 'US':
        return '\$';
      case 'GB':
        return '£';
      case 'ES':
      case 'FR':
      case 'DE':
        return '€';
      case 'JP':
        return '¥';
      case 'CN':
        return '¥';
      case 'IN':
        return '₹';
      case 'SA':
        return 'ر.س';
      default:
        return '\$';
    }
  }
}

/// Information about a locale for display purposes
class LocaleDisplayInfo {
  final String displayName;
  final String nativeName;
  final String flag;
  
  const LocaleDisplayInfo({
    required this.displayName,
    required this.nativeName,
    required this.flag,
  });
}

/// Extension to add convenience methods to Locale
extension LocaleExtensions on Locale {
  /// Get display name for this locale
  String get displayName => LocaleService.formatLocaleForDisplay(this);
  
  /// Get native name for this locale
  String get nativeName => LocaleService.getNativeName(this);
  
  /// Get flag emoji for this locale
  String get flagEmoji => LocaleService.getFlagEmoji(this);
  
  /// Check if this locale is RTL
  bool get isRTL => LocaleService.isRTL(this);
  
  /// Get text direction for this locale
  TextDirection get textDirection => LocaleService.getTextDirection(this);
  
  /// Convert to string representation
  String get toStringRepresentation => LocaleService.localeToString(this);
  
  /// Get appropriate date format for this locale
  String get dateFormat => LocaleService.getDateFormat(this);
  
  /// Get appropriate time format for this locale
  String get timeFormat => LocaleService.getTimeFormat(this);
  
  /// Get currency symbol for this locale
  String get currencySymbol => LocaleService.getCurrencySymbol(this);
}

/// Utility class for common locale operations
class LocaleUtils {
  /// Compare two locales for equality (ignoring case)
  static bool areEqual(Locale locale1, Locale locale2) {
    return locale1.languageCode.toLowerCase() == locale2.languageCode.toLowerCase() &&
           locale1.countryCode?.toLowerCase() == locale2.countryCode?.toLowerCase();
  }
  
  /// Check if a locale is supported
  static bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any((supported) => areEqual(supported, locale));
  }
  
  /// Get all language codes from supported locales
  static Set<String> get supportedLanguageCodes {
    return AppLocalizations.supportedLocales
        .map((locale) => locale.languageCode)
        .toSet();
  }
  
  /// Get all country codes from supported locales
  static Set<String> get supportedCountryCodes {
    return AppLocalizations.supportedLocales
        .where((locale) => locale.countryCode != null)
        .map((locale) => locale.countryCode!)
        .toSet();
  }
  
  /// Group supported locales by language
  static Map<String, List<Locale>> get localesByLanguage {
    final Map<String, List<Locale>> grouped = {};
    
    for (final locale in AppLocalizations.supportedLocales) {
      grouped.putIfAbsent(locale.languageCode, () => []).add(locale);
    }
    
    return grouped;
  }
}