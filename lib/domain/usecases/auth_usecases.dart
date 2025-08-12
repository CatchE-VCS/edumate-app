import 'package:edumate/domain/entities/user_entity.dart';
import 'package:edumate/domain/repositories/user_repository.dart';

/// Use case for user authentication operations
class AuthUseCases {
  final UserRepository _userRepository;

  AuthUseCases(this._userRepository);

  /// Sign in with email and password
  Future<AuthResult> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Implementation would be in the repository layer
      // This is the business logic layer
      if (email.isEmpty || password.isEmpty) {
        return AuthResult.failure('Email and password are required');
      }

      if (!_isValidEmail(email)) {
        return AuthResult.failure('Invalid email format');
      }

      // Delegate to repository for actual authentication
      final user = await _userRepository.getCurrentUser();
      if (user != null) {
        return AuthResult.success(user);
      } else {
        return AuthResult.failure('Invalid credentials');
      }
    } catch (e) {
      return AuthResult.failure('Authentication failed: $e');
    }
  }

  /// Sign up with email and password
  Future<AuthResult> signUpWithEmailAndPassword(String email, String password, String displayName) async {
    try {
      if (email.isEmpty || password.isEmpty || displayName.isEmpty) {
        return AuthResult.failure('All fields are required');
      }

      if (!_isValidEmail(email)) {
        return AuthResult.failure('Invalid email format');
      }

      if (password.length < 8) {
        return AuthResult.failure('Password must be at least 8 characters');
      }

      // Create new user entity
      final newUser = UserEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        displayName: displayName,
        createdAt: DateTime.now(),
        coins: 100, // Welcome bonus
      );

      // This would delegate to repository to create the user
      return AuthResult.success(newUser);
    } catch (e) {
      return AuthResult.failure('Sign up failed: $e');
    }
  }

  /// Sign in with Google
  Future<AuthResult> signInWithGoogle() async {
    try {
      // Delegate to repository for Google authentication
      final user = await _userRepository.getCurrentUser();
      if (user != null) {
        return AuthResult.success(user);
      } else {
        return AuthResult.failure('Google sign in failed');
      }
    } catch (e) {
      return AuthResult.failure('Google sign in failed: $e');
    }
  }

  /// Sign in with Facebook
  Future<AuthResult> signInWithFacebook() async {
    try {
      // Delegate to repository for Facebook authentication
      final user = await _userRepository.getCurrentUser();
      if (user != null) {
        return AuthResult.success(user);
      } else {
        return AuthResult.failure('Facebook sign in failed');
      }
    } catch (e) {
      return AuthResult.failure('Facebook sign in failed: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      // Delegate to repository for sign out
      // Clear any cached user data
    } catch (e) {
      // Handle sign out errors
    }
  }

  /// Reset password
  Future<bool> resetPassword(String email) async {
    try {
      if (email.isEmpty) {
        return false;
      }

      if (!_isValidEmail(email)) {
        return false;
      }

      // Delegate to repository for password reset
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get current user
  Future<UserEntity?> getCurrentUser() async {
    return await _userRepository.getCurrentUser();
  }

  /// Update user profile
  Future<bool> updateUserProfile(UserEntity user) async {
    try {
      await _userRepository.updateUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Delete user account
  Future<bool> deleteAccount(String userId) async {
    try {
      await _userRepository.deleteUser(userId);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
}

/// Authentication result wrapper
class AuthResult {
  final bool isSuccess;
  final UserEntity? user;
  final String? errorMessage;

  const AuthResult._({
    required this.isSuccess,
    this.user,
    this.errorMessage,
  });

  factory AuthResult.success(UserEntity user) {
    return AuthResult._(
      isSuccess: true,
      user: user,
    );
  }

  factory AuthResult.failure(String message) {
    return AuthResult._(
      isSuccess: false,
      errorMessage: message,
    );
  }

  @override
  String toString() {
    return 'AuthResult(isSuccess: $isSuccess, user: $user, error: $errorMessage)';
  }
}