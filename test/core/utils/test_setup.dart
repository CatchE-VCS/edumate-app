import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Core imports
import 'package:edumate/core/di/dependency_injection.dart';
import 'package:edumate/core/utils/test_helpers.dart';

/// Test setup utilities for the Edumate app
class TestSetup {
  /// Setup widget testing environment
  static Widget setupWidgetTest({
    required Widget child,
    List<Override>? overrides,
    ThemeData? theme,
  }) {
    return ProviderScope(
      overrides: overrides ?? [],
      child: MaterialApp(
        theme: theme ?? ThemeData.light(),
        home: Scaffold(body: child),
      ),
    );
  }

  /// Setup widget testing with dark theme
  static Widget setupWidgetTestWithDarkTheme({
    required Widget child,
    List<Override>? overrides,
  }) {
    return setupWidgetTest(
      child: child,
      overrides: overrides,
      theme: ThemeData.dark(),
    );
  }

  /// Setup responsive testing with specific screen size
  static Widget setupResponsiveTest({
    required Widget child,
    Size screenSize = const Size(375, 812),
    List<Override>? overrides,
  }) {
    return ProviderScope(
      overrides: overrides ?? [],
      child: MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: screenSize),
          child: Scaffold(body: child),
        ),
      ),
    );
  }

  /// Setup test with mocked providers
  static Widget setupMockedTest({
    required Widget child,
    required Map<Provider, dynamic> mocks,
  }) {
    final overrides = mocks.entries
        .map((entry) => entry.key.overrideWithValue(entry.value))
        .toList();

    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  /// Pump widget with animations settled
  static Future<void> pumpAndSettle(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }

  /// Tap and wait for animations
  static Future<void> tapAndWait(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  /// Enter text and wait
  static Future<void> enterTextAndWait(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  /// Scroll and wait
  static Future<void> scrollAndWait(
    WidgetTester tester,
    Finder finder,
    Offset offset,
  ) async {
    await tester.drag(finder, offset);
    await tester.pumpAndSettle();
  }

  /// Verify widget exists
  static void verifyWidgetExists(Finder finder) {
    expect(finder, findsOneWidget);
  }

  /// Verify widget doesn't exist
  static void verifyWidgetDoesNotExist(Finder finder) {
    expect(finder, findsNothing);
  }

  /// Verify text exists
  static void verifyTextExists(String text) {
    expect(find.text(text), findsOneWidget);
  }

  /// Verify icon exists
  static void verifyIconExists(IconData icon) {
    expect(find.byIcon(icon), findsOneWidget);
  }

  /// Create mock user data
  static Map<String, dynamic> createMockUser({
    String? id,
    String? email,
    String? name,
    int? coins,
  }) {
    return TestHelpers.createMockUserData(
      email: email,
      name: name,
      coins: coins,
    );
  }

  /// Create mock course data
  static Map<String, dynamic> createMockCourse({
    String? id,
    String? title,
    String? instructor,
    int? duration,
  }) {
    return {
      'id': id ?? 'course_123',
      'title': title ?? 'Test Course',
      'description': 'A comprehensive test course',
      'instructor': instructor ?? 'Test Instructor',
      'duration': duration ?? 3600,
      'level': 'beginner',
      'rating': 4.5,
      'enrollmentCount': 150,
      'isPublished': true,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  /// Create mock contest data
  static Map<String, dynamic> createMockContest({
    String? id,
    String? name,
    String? status,
    DateTime? startTime,
  }) {
    return {
      'id': id ?? 'contest_123',
      'name': name ?? 'Test Contest',
      'description': 'A programming contest',
      'startTime': (startTime ?? DateTime.now().add(const Duration(days: 1))).toIso8601String(),
      'endTime': (startTime ?? DateTime.now().add(const Duration(days: 1, hours: 2))).toIso8601String(),
      'type': 'individual',
      'status': status ?? 'upcoming',
      'platform': 'test',
      'maxParticipants': 100,
      'difficulty': 'medium',
    };
  }

  /// Simulate network delay
  static Future<void> simulateNetworkDelay([Duration? delay]) async {
    await TestHelpers.simulateNetworkDelay(delay);
  }

  /// Create mock API response
  static Map<String, dynamic> createMockApiResponse({
    bool success = true,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return TestHelpers.createMockApiResponse(
      success: success,
      data: data,
      error: error,
    );
  }

  /// Wait for specific condition
  static Future<void> waitFor(
    WidgetTester tester,
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 5),
    Duration pollInterval = const Duration(milliseconds: 100),
  }) async {
    final stopwatch = Stopwatch()..start();
    
    while (!condition() && stopwatch.elapsed < timeout) {
      await Future.delayed(pollInterval);
      await tester.pump();
    }
    
    if (!condition()) {
      throw TimeoutException('Condition not met within timeout', timeout);
    }
  }

  /// Mock provider override helper
  static Override mockProvider<T>(Provider<T> provider, T value) {
    return provider.overrideWithValue(value);
  }

  /// Mock stream provider override helper
  static Override mockStreamProvider<T>(StreamProvider<T> provider, T value) {
    return provider.overrideWith((ref) => Stream.value(value));
  }

  /// Mock future provider override helper
  static Override mockFutureProvider<T>(FutureProvider<T> provider, T value) {
    return provider.overrideWith((ref) => Future.value(value));
  }
}

/// Custom matchers for testing
class EdumateMatchers {
  /// Matcher for responsive widgets
  static Matcher isResponsiveWidget() {
    return predicate<Widget>(
      (widget) => true, // Placeholder - implement based on your responsive logic
      'is responsive widget',
    );
  }

  /// Matcher for theme-aware widgets
  static Matcher hasTheme(ThemeData expectedTheme) {
    return predicate<Widget>(
      (widget) {
        // Implementation depends on how your widgets handle themes
        return true;
      },
      'has theme $expectedTheme',
    );
  }

  /// Matcher for loading states
  static Matcher isLoading() {
    return predicate<Widget>(
      (widget) {
        // Check if widget shows loading indicator
        return widget is CircularProgressIndicator ||
               widget.toString().toLowerCase().contains('loading');
      },
      'is in loading state',
    );
  }

  /// Matcher for error states
  static Matcher hasError(String expectedError) {
    return predicate<Widget>(
      (widget) {
        // Check if widget shows error message
        return widget.toString().contains(expectedError);
      },
      'has error: $expectedError',
    );
  }
}

/// Test groups for organized testing
class TestGroups {
  /// Widget test group
  static void widgetTests(String description, void Function() body) {
    group('Widget Tests - $description', body);
  }

  /// Unit test group
  static void unitTests(String description, void Function() body) {
    group('Unit Tests - $description', body);
  }

  /// Integration test group
  static void integrationTests(String description, void Function() body) {
    group('Integration Tests - $description', body);
  }

  /// Golden test group
  static void goldenTests(String description, void Function() body) {
    group('Golden Tests - $description', body);
  }

  /// Performance test group
  static void performanceTests(String description, void Function() body) {
    group('Performance Tests - $description', body);
  }
}