import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// App imports
import 'package:edumate/main.dart';
import 'package:edumate/core/di/dependency_injection.dart';
import 'package:edumate/src/settings/settings_controller.dart';
import 'package:edumate/src/settings/settings_service.dart';

// Test imports
import 'core/utils/test_setup.dart';

void main() {
  group('Edumate App Tests', () {
    late SettingsController settingsController;

    setUp(() async {
      // Initialize dependencies for testing
      DependencyInjection.init();
      settingsController = SettingsController(SettingsService());
      await settingsController.loadSettings();
    });

    tearDown(() {
      // Clean up after each test
      DependencyInjection.dispose();
    });

    testWidgets('App should start and display without crashing', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(
        ProviderScope(
          child: EdumateApp(settingsController: settingsController),
        ),
      );

      // Verify app starts without crashing
      expect(find.byType(MaterialApp), findsOneWidget);
      
      // The app should start without throwing exceptions
      await tester.pumpAndSettle();
    });

    testWidgets('App should have proper navigation structure', (WidgetTester tester) async {
      await TestSetup.pumpAndSettle(
        tester,
        TestSetup.setupWidgetTest(
          child: EdumateApp(settingsController: settingsController),
        ),
      );

      // App should have proper scaffold structure
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('App should support responsive design', (WidgetTester tester) async {
      // Test mobile screen size
      await TestSetup.pumpAndSettle(
        tester,
        TestSetup.setupResponsiveTest(
          child: const Text('Responsive Test'),
          screenSize: const Size(375, 812), // iPhone size
        ),
      );

      expect(find.text('Responsive Test'), findsOneWidget);

      // Test tablet screen size
      await tester.pumpWidget(
        TestSetup.setupResponsiveTest(
          child: const Text('Tablet Test'),
          screenSize: const Size(768, 1024), // iPad size
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Tablet Test'), findsOneWidget);
    });

    group('State Management Tests', () {
      testWidgets('Riverpod providers should be accessible', (WidgetTester tester) async {
        bool providerAccessible = false;

        await TestSetup.pumpAndSettle(
          tester,
          ProviderScope(
            child: Consumer(
              builder: (context, ref, child) {
                try {
                  // Test accessing a global provider
                  ref.read(globalLoadingProvider);
                  providerAccessible = true;
                } catch (e) {
                  providerAccessible = false;
                }
                return const Text('Provider Test');
              },
            ),
          ),
        );

        expect(find.text('Provider Test'), findsOneWidget);
        expect(providerAccessible, isTrue);
      });
    });

    group('Theme Tests', () {
      testWidgets('App should support light theme', (WidgetTester tester) async {
        await TestSetup.pumpAndSettle(
          tester,
          TestSetup.setupWidgetTest(
            child: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                return Container(
                  color: theme.scaffoldBackgroundColor,
                  child: Text(
                    'Light Theme',
                    style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                  ),
                );
              },
            ),
          ),
        );

        expect(find.text('Light Theme'), findsOneWidget);
      });

      testWidgets('App should support dark theme', (WidgetTester tester) async {
        await TestSetup.pumpAndSettle(
          tester,
          TestSetup.setupWidgetTestWithDarkTheme(
            child: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                return Container(
                  color: theme.scaffoldBackgroundColor,
                  child: Text(
                    'Dark Theme',
                    style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                  ),
                );
              },
            ),
          ),
        );

        expect(find.text('Dark Theme'), findsOneWidget);
      });
    });

    group('Performance Tests', () {
      testWidgets('App should render within acceptable time', (WidgetTester tester) async {
        final stopwatch = Stopwatch()..start();

        await TestSetup.pumpAndSettle(
          tester,
          ProviderScope(
            child: EdumateApp(settingsController: settingsController),
          ),
        );

        stopwatch.stop();

        // Ensure app renders within reasonable time
        expect(stopwatch.elapsedMilliseconds, lessThan(5000));
      });
    });

    group('Integration Tests', () {
      testWidgets('App should handle navigation', (WidgetTester tester) async {
        await TestSetup.pumpAndSettle(
          tester,
          ProviderScope(
            child: EdumateApp(settingsController: settingsController),
          ),
        );

        // App should have proper navigation structure
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });
  });

  group('Test Utilities Tests', () {
    test('Mock data generators should work correctly', () {
      final mockUser = TestSetup.createMockUser(
        email: 'test@example.com',
        name: 'Test User',
        coins: 1500,
      );

      expect(mockUser['email'], equals('test@example.com'));
      expect(mockUser['name'], equals('Test User'));
      expect(mockUser['coins'], equals(1500));
    });

    test('Mock API response should be properly formatted', () {
      final response = TestSetup.createMockApiResponse(
        success: true,
        data: {'message': 'Success'},
      );

      expect(response['success'], isTrue);
      expect(response['data']['message'], equals('Success'));
      expect(response.containsKey('timestamp'), isTrue);
    });
  });
}
