import 'package:flutter/material.dart';
import 'package:edumate/core/utils/responsive_utils.dart';

/// Extension methods for BuildContext to provide convenient utilities
extension ContextExtensions on BuildContext {
  /// Get the current theme
  ThemeData get theme => Theme.of(this);

  /// Get the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get the current text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get screen dimensions
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// Device type checks
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);

  /// Get responsive padding
  EdgeInsets get responsivePadding => ResponsiveUtils.getResponsivePadding(this);

  /// Get responsive margin
  EdgeInsets get responsiveMargin => ResponsiveUtils.getResponsiveMargin(this);

  /// Get responsive font size
  double responsiveFontSize(double baseFontSize) =>
      ResponsiveUtils.getResponsiveFontSize(this, baseFontSize);

  /// Get responsive width/height
  double responsiveWidth(double percentage) =>
      ResponsiveUtils.getResponsiveWidth(this, percentage);
  
  double responsiveHeight(double percentage) =>
      ResponsiveUtils.getResponsiveHeight(this, percentage);

  /// Navigation helpers
  NavigatorState get navigator => Navigator.of(this);
  
  void pushNamed(String routeName, {Object? arguments}) {
    navigator.pushNamed(routeName, arguments: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    navigator.pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop([Object? result]) {
    navigator.pop(result);
  }

  bool canPop() {
    return navigator.canPop();
  }

  /// Show snackbar
  void showSnackBar(String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        duration: duration,
        backgroundColor: backgroundColor,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Show error snackbar
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
    );
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// Focus scope helpers
  FocusScopeNode get focusScope => FocusScope.of(this);
  
  void unfocus() {
    focusScope.unfocus();
  }

  void requestFocus(FocusNode focusNode) {
    focusScope.requestFocus(focusNode);
  }

  /// Keyboard visibility
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Safe area insets
  EdgeInsets get safeAreaInsets => MediaQuery.of(this).padding;

  /// Platform checks
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isWeb => Theme.of(this).platform == TargetPlatform.linux ||
                   Theme.of(this).platform == TargetPlatform.macOS ||
                   Theme.of(this).platform == TargetPlatform.windows;

  /// Localization helpers (if available)
  Locale get locale => Localizations.localeOf(this);
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
}