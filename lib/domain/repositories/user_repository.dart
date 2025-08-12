import 'package:edumate/domain/entities/user_entity.dart';

/// Repository interface for user data operations
abstract class UserRepository {
  /// Get current authenticated user
  Future<UserEntity?> getCurrentUser();

  /// Get user by ID
  Future<UserEntity?> getUserById(String userId);

  /// Update user information
  Future<void> updateUser(UserEntity user);

  /// Delete user account
  Future<void> deleteUser(String userId);

  /// Update user coins
  Future<void> updateUserCoins(String userId, int coins);

  /// Add course to user's enrolled courses
  Future<void> enrollInCourse(String userId, String courseId);

  /// Mark course as completed
  Future<void> completeCourse(String userId, String courseId);

  /// Update user preferences
  Future<void> updateUserPreferences(String userId, Map<String, dynamic> preferences);

  /// Get user's enrolled courses
  Future<List<String>> getEnrolledCourses(String userId);

  /// Get user's completed courses
  Future<List<String>> getCompletedCourses(String userId);

  /// Search users by name or email
  Future<List<UserEntity>> searchUsers(String query, {int limit = 20});

  /// Get user statistics
  Future<Map<String, dynamic>> getUserStats(String userId);
}