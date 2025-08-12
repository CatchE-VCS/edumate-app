import 'package:hooks_riverpod/hooks_riverpod.dart';

// Core imports
import 'package:edumate/core/network/network_service.dart';
import 'package:edumate/core/utils/security_manager.dart';
import 'package:edumate/core/utils/performance_monitor.dart';

// Data layer imports
import 'package:edumate/data/repositories/auth_controller.dart';
import 'package:edumate/data/repositories/user_info_storage.dart';
import 'package:edumate/data/repositories/contest_controller.dart';

// Domain layer imports
import 'package:edumate/domain/repositories/user_repository.dart';
import 'package:edumate/domain/repositories/course_repository.dart';
import 'package:edumate/domain/repositories/contest_repository.dart';
import 'package:edumate/domain/usecases/auth_usecases.dart';

// Data layer providers
import 'package:edumate/data/repositories/user_repository_impl.dart';
import 'package:edumate/data/repositories/course_repository_impl.dart';
import 'package:edumate/data/repositories/contest_repository_impl.dart';

/// Dependency injection container for the Edumate app
class DependencyInjection {
  static final DependencyInjection _instance = DependencyInjection._internal();
  factory DependencyInjection() => _instance;
  DependencyInjection._internal();

  /// Initialize all dependencies
  static void init() {
    // Core services are initialized here
    // All providers are automatically registered with Riverpod
  }

  /// Dispose all dependencies
  static void dispose() {
    NetworkService().dispose();
    PerformanceMonitor().dispose();
  }
}

// =============================================================================
// CORE PROVIDERS
// =============================================================================

/// Network service provider
final networkServiceProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});

/// Security manager provider
final securityManagerProvider = Provider<SecurityManager>((ref) {
  return SecurityManager();
});

/// Performance monitor provider
final performanceMonitorProvider = Provider<PerformanceMonitor>((ref) {
  return PerformanceMonitor();
});

// =============================================================================
// REPOSITORY PROVIDERS
// =============================================================================

/// User repository provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return UserRepositoryImpl(networkService);
});

/// Course repository provider
final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return CourseRepositoryImpl(networkService);
});

/// Contest repository provider
final contestRepositoryProvider = Provider<ContestRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return ContestRepositoryImpl(networkService);
});

// =============================================================================
// USE CASE PROVIDERS
// =============================================================================

/// Authentication use cases provider
final authUseCasesProvider = Provider<AuthUseCases>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthUseCases(userRepository);
});

// =============================================================================
// APPLICATION STATE PROVIDERS
// =============================================================================

/// Current user provider
final currentUserProvider = StreamProvider((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  // Return stream of current user changes
  return Stream.fromFuture(userRepository.getCurrentUser()).asStream();
});

/// Authentication state provider
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authUseCases = ref.watch(authUseCasesProvider);
  return AuthStateNotifier(authUseCases);
});

/// Loading state provider for global loading indicators
final globalLoadingProvider = StateProvider<bool>((ref) => false);

/// Error state provider for global error handling
final globalErrorProvider = StateProvider<String?>((ref) => null);

// =============================================================================
// FEATURE-SPECIFIC PROVIDERS
// =============================================================================

/// User profile provider
final userProfileProvider = FutureProvider((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  return await userRepository.getCurrentUser();
});

/// User courses provider
final userCoursesProvider = FutureProvider((ref) async {
  final courseRepository = ref.watch(courseRepositoryProvider);
  final user = await ref.watch(userProfileProvider.future);
  if (user != null) {
    return await courseRepository.getUserEnrolledCourses(user.id);
  }
  return [];
});

/// Featured courses provider
final featuredCoursesProvider = FutureProvider((ref) async {
  final courseRepository = ref.watch(courseRepositoryProvider);
  return await courseRepository.getFeaturedCourses();
});

/// Upcoming contests provider
final upcomingContestsProvider = FutureProvider((ref) async {
  final contestRepository = ref.watch(contestRepositoryProvider);
  return await contestRepository.getUpcomingContests();
});

/// User statistics provider
final userStatsProvider = FutureProvider((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  final user = await ref.watch(userProfileProvider.future);
  if (user != null) {
    return await userRepository.getUserStats(user.id);
  }
  return <String, dynamic>{};
});

// =============================================================================
// CONFIGURATION PROVIDERS
// =============================================================================

/// App configuration provider
final appConfigProvider = Provider<AppConfiguration>((ref) {
  return AppConfiguration();
});

/// Theme configuration provider
final themeConfigProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

/// Locale configuration provider
final localeConfigProvider = StateProvider<String>((ref) {
  return 'en'; // Default locale
});

// =============================================================================
// UTILITY PROVIDERS
// =============================================================================

/// Device info provider
final deviceInfoProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  // Return device information for analytics and debugging
  return {
    'platform': 'flutter',
    'timestamp': DateTime.now().toIso8601String(),
  };
});

/// Connectivity provider
final connectivityProvider = StreamProvider<bool>((ref) {
  // Return connectivity stream
  return Stream.periodic(const Duration(seconds: 5), (count) => true);
});

// =============================================================================
// SUPPORTING CLASSES
// =============================================================================

/// Application configuration class
class AppConfiguration {
  final String appName = 'Edumate';
  final String version = '1.0.0';
  final bool isDebugMode = bool.fromEnvironment('dart.vm.product') == false;
  final String apiBaseUrl = const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.edumate.com',
  );
  final Duration networkTimeout = const Duration(seconds: 30);
  final int maxRetries = 3;
}

/// Authentication state notifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthUseCases _authUseCases;

  AuthStateNotifier(this._authUseCases) : super(const AuthState.initial());

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const AuthState.loading();
    
    try {
      final result = await _authUseCases.signInWithEmailAndPassword(email, password);
      
      if (result.isSuccess && result.user != null) {
        state = AuthState.authenticated(result.user!);
      } else {
        state = AuthState.error(result.errorMessage ?? 'Authentication failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _authUseCases.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Reset to initial state
  void reset() {
    state = const AuthState.initial();
  }
}

/// Authentication state
abstract class AuthState {
  const AuthState();

  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

class _Initial extends AuthState {
  const _Initial();
}

class _Loading extends AuthState {
  const _Loading();
}

class _Authenticated extends AuthState {
  final dynamic user;
  const _Authenticated(this.user);
}

class _Unauthenticated extends AuthState {
  const _Unauthenticated();
}

class _Error extends AuthState {
  final String message;
  const _Error(this.message);
}