import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Test utilities for consistent testing across the app
class TestHelpers {
  /// Create a test widget wrapped with necessary providers
  static Widget createTestWidget({
    required Widget child,
    List<Override>? overrides,
    ThemeData? theme,
  }) {
    return ProviderScope(
      overrides: overrides ?? [],
      child: MaterialApp(
        theme: theme ?? ThemeData.light(),
        home: child,
      ),
    );
  }

  /// Create a test widget with dark theme
  static Widget createTestWidgetWithDarkTheme({
    required Widget child,
    List<Override>? overrides,
  }) {
    return createTestWidget(
      child: child,
      overrides: overrides,
      theme: ThemeData.dark(),
    );
  }

  /// Create a mock responsive context for testing
  static Widget createResponsiveTestWidget({
    required Widget child,
    Size screenSize = const Size(375, 812), // iPhone 11 size
    List<Override>? overrides,
  }) {
    return ProviderScope(
      overrides: overrides ?? [],
      child: MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: screenSize),
          child: child,
        ),
      ),
    );
  }

  /// Simulate network delay for testing
  static Future<void> simulateNetworkDelay([Duration? delay]) async {
    await Future.delayed(delay ?? const Duration(milliseconds: 100));
  }

  /// Create mock user data
  static Map<String, dynamic> createMockUserData({
    String? email,
    String? name,
    int? coins,
  }) {
    return {
      'email': email ?? 'test@example.com',
      'name': name ?? 'Test User',
      'coins': coins ?? 1000,
      'id': 'test-user-id',
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  /// Create mock redemption item
  static Map<String, dynamic> createMockRedemptionItem({
    String? id,
    String? name,
    int? cost,
  }) {
    return {
      'id': id ?? 'test-item',
      'name': name ?? 'Test Item',
      'description': 'Test item description',
      'cost': cost ?? 500,
      'imageUrl': 'assets/images/test.png',
      'availableSizes': ['Small', 'Medium', 'Large'],
      'isAvailable': true,
    };
  }

  /// Common test expectations
  static void expectWidgetToBePresent(WidgetTester tester, Finder finder) {
    expect(finder, findsOneWidget);
  }

  static void expectWidgetToBeAbsent(WidgetTester tester, Finder finder) {
    expect(finder, findsNothing);
  }

  static void expectTextToBePresent(WidgetTester tester, String text) {
    expect(find.text(text), findsOneWidget);
  }

  static void expectIconToBePresent(WidgetTester tester, IconData icon) {
    expect(find.byIcon(icon), findsOneWidget);
  }

  /// Helper to tap and wait for animations
  static Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  /// Helper to enter text and wait
  static Future<void> enterTextAndSettle(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  /// Helper to scroll and wait
  static Future<void> scrollAndSettle(
    WidgetTester tester,
    Finder finder,
    Offset offset,
  ) async {
    await tester.drag(finder, offset);
    await tester.pumpAndSettle();
  }

  /// Create a mock HTTP response
  static Map<String, dynamic> createMockApiResponse({
    bool success = true,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return {
      'success': success,
      'data': data ?? {},
      'error': error,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Verify form validation
  static void verifyFormValidation(
    WidgetTester tester, {
    required Finder submitButton,
    required List<String> expectedErrors,
  }) {
    // Tap submit without filling form
    tester.tap(submitButton);
    tester.pump();

    // Check for validation errors
    for (final error in expectedErrors) {
      expect(find.text(error), findsOneWidget);
    }
  }

  /// Mock gesture detector taps
  static Future<void> mockTapGesture(
    WidgetTester tester,
    Finder finder,
  ) async {
    final gesture = await tester.startGesture(
      tester.getCenter(finder),
    );
    await gesture.up();
    await tester.pumpAndSettle();
  }
}

/// Custom matchers for testing
class CustomMatchers {
  /// Check if widget has specific color
  static Matcher hasColor(Color expectedColor) {
    return predicate<Widget>((widget) {
      if (widget is Container) {
        final decoration = widget.decoration as BoxDecoration?;
        return decoration?.color == expectedColor;
      }
      return false;
    }, 'has color $expectedColor');
  }

  /// Check if text has specific style
  static Matcher hasTextStyle(TextStyle expectedStyle) {
    return predicate<Text>((text) {
      return text.style?.fontSize == expectedStyle.fontSize &&
          text.style?.fontWeight == expectedStyle.fontWeight &&
          text.style?.color == expectedStyle.color;
    }, 'has text style $expectedStyle');
  }

  /// Check if widget is responsive (adapts to screen size)
  static Matcher isResponsive() {
    return predicate<Widget>((widget) {
      // This would need to be implemented based on your responsive logic
      return true; // Placeholder
    }, 'is responsive');
  }
}

/// Mock classes for testing
class MockNetworkService {
  Future<Map<String, dynamic>> get(String url) async {
    await TestHelpers.simulateNetworkDelay();
    return TestHelpers.createMockApiResponse();
  }

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> data) async {
    await TestHelpers.simulateNetworkDelay();
    return TestHelpers.createMockApiResponse();
  }
}

/// Test data generators
class TestDataGenerators {
  static List<Map<String, dynamic>> generateMockRedemptionItems(int count) {
    return List.generate(count, (index) {
      return TestHelpers.createMockRedemptionItem(
        id: 'item-$index',
        name: 'Test Item $index',
        cost: (index + 1) * 100,
      );
    });
  }

  static Map<String, dynamic> generateMockRedemptionRequest() {
    return {
      'email': 'test@example.com',
      'addressLine1': '123 Test Street',
      'addressLine2': 'Apt 4B',
      'phoneNumber': '+1234567890',
      'selectedSize': 'Medium',
      'itemId': 'test-item',
      'cost': 500,
    };
  }
}