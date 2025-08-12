import 'package:edumate/domain/entities/user_entity.dart';
import 'package:edumate/domain/repositories/user_repository.dart';
import 'package:edumate/core/network/network_service.dart';
import 'package:edumate/core/errors/failures.dart';

/// Implementation of UserRepository
class UserRepositoryImpl implements UserRepository {
  final NetworkService _networkService;

  UserRepositoryImpl(this._networkService);

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      // In a real app, this would make an API call
      // For now, return a mock user or null
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock current user - replace with actual API call
      return const UserEntity(
        id: 'user_123',
        email: 'user@example.com',
        displayName: 'John Doe',
        photoUrl: 'https://example.com/avatar.jpg',
        coins: 2500,
        createdAt: null, // Would be DateTime.now() in real implementation
        lastLoginAt: null,
        enrolledCourses: ['course_1', 'course_2'],
        completedCourses: ['course_1'],
        preferences: {'theme': 'dark', 'notifications': true},
      );
    } catch (e) {
      throw ServerFailure(message: 'Failed to get current user: $e');
    }
  }

  @override
  Future<UserEntity?> getUserById(String userId) async {
    try {
      final result = await _networkService.get<Map<String, dynamic>>(
        url: '/users/$userId',
        parser: (data) => data as Map<String, dynamic>,
      );

      if (result.isSuccess && result.data != null) {
        return UserEntity.fromJson(result.data!);
      }
      return null;
    } catch (e) {
      throw ServerFailure(message: 'Failed to get user: $e');
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    try {
      await _networkService.put<Map<String, dynamic>>(
        url: '/users/${user.id}',
        parser: (data) => data as Map<String, dynamic>,
        body: user.toJson(),
      );
    } catch (e) {
      throw ServerFailure(message: 'Failed to update user: $e');
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await _networkService.delete<Map<String, dynamic>>(
        url: '/users/$userId',
        parser: (data) => data as Map<String, dynamic>,
      );
    } catch (e) {
      throw ServerFailure(message: 'Failed to delete user: $e');
    }
  }

  @override
  Future<void> updateUserCoins(String userId, int coins) async {
    try {
      await _networkService.put<Map<String, dynamic>>(
        url: '/users/$userId/coins',
        parser: (data) => data as Map<String, dynamic>,
        body: {'coins': coins},
      );
    } catch (e) {
      throw ServerFailure(message: 'Failed to update user coins: $e');
    }
  }

  @override
  Future<void> enrollInCourse(String userId, String courseId) async {
    try {
      await _networkService.post<Map<String, dynamic>>(
        url: '/users/$userId/courses',
        parser: (data) => data as Map<String, dynamic>,
        body: {'courseId': courseId, 'action': 'enroll'},
      );
    } catch (e) {
      throw ServerFailure(message: 'Failed to enroll in course: $e');
    }
  }

  @override
  Future<void> completeCourse(String userId, String courseId) async {
    try {
      await _networkService.post<Map<String, dynamic>>(
        url: '/users/$userId/courses',
        parser: (data) => data as Map<String, dynamic>,
        body: {'courseId': courseId, 'action': 'complete'},
      );
    } catch (e) {
      throw ServerFailure(message: 'Failed to complete course: $e');
    }
  }

  @override
  Future<void> updateUserPreferences(String userId, Map<String, dynamic> preferences) async {
    try {
      await _networkService.put<Map<String, dynamic>>(
        url: '/users/$userId/preferences',
        parser: (data) => data as Map<String, dynamic>,
        body: preferences,
      );
    } catch (e) {
      throw ServerFailure(message: 'Failed to update preferences: $e');
    }
  }

  @override
  Future<List<String>> getEnrolledCourses(String userId) async {
    try {
      final result = await _networkService.get<List<dynamic>>(
        url: '/users/$userId/enrolled-courses',
        parser: (data) => data as List<dynamic>,
      );

      if (result.isSuccess && result.data != null) {
        return result.data!.map((courseId) => courseId.toString()).toList();
      }
      return [];
    } catch (e) {
      throw ServerFailure(message: 'Failed to get enrolled courses: $e');
    }
  }

  @override
  Future<List<String>> getCompletedCourses(String userId) async {
    try {
      final result = await _networkService.get<List<dynamic>>(
        url: '/users/$userId/completed-courses',
        parser: (data) => data as List<dynamic>,
      );

      if (result.isSuccess && result.data != null) {
        return result.data!.map((courseId) => courseId.toString()).toList();
      }
      return [];
    } catch (e) {
      throw ServerFailure(message: 'Failed to get completed courses: $e');
    }
  }

  @override
  Future<List<UserEntity>> searchUsers(String query, {int limit = 20}) async {
    try {
      final result = await _networkService.get<List<dynamic>>(
        url: '/users/search?q=$query&limit=$limit',
        parser: (data) => data as List<dynamic>,
      );

      if (result.isSuccess && result.data != null) {
        return result.data!
            .map((userData) => UserEntity.fromJson(userData as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      throw ServerFailure(message: 'Failed to search users: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      final result = await _networkService.get<Map<String, dynamic>>(
        url: '/users/$userId/stats',
        parser: (data) => data as Map<String, dynamic>,
      );

      if (result.isSuccess && result.data != null) {
        return result.data!;
      }
      return {};
    } catch (e) {
      throw ServerFailure(message: 'Failed to get user stats: $e');
    }
  }
}

/// Extension to add JSON serialization to UserEntity
extension UserEntityJson on UserEntity {
  /// Convert UserEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'coins': coins,
      'createdAt': createdAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'enrolledCourses': enrolledCourses,
      'completedCourses': completedCourses,
      'preferences': preferences,
    };
  }

  /// Create UserEntity from JSON
  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      coins: (json['coins'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      enrolledCourses: (json['enrolledCourses'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      completedCourses: (json['completedCourses'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      preferences: (json['preferences'] as Map<String, dynamic>?) ?? {},
    );
  }
}