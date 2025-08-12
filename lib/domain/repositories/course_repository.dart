import 'package:edumate/domain/entities/course_entity.dart';

/// Repository interface for course data operations
abstract class CourseRepository {
  /// Get all published courses
  Future<List<CourseEntity>> getAllCourses();

  /// Get course by ID
  Future<CourseEntity?> getCourseById(String courseId);

  /// Get courses by instructor
  Future<List<CourseEntity>> getCoursesByInstructor(String instructorId);

  /// Search courses by query
  Future<List<CourseEntity>> searchCourses(String query, {
    int limit = 20,
    CourseLevel? level,
    List<String>? tags,
  });

  /// Get featured courses
  Future<List<CourseEntity>> getFeaturedCourses({int limit = 10});

  /// Get popular courses
  Future<List<CourseEntity>> getPopularCourses({int limit = 10});

  /// Get courses by category/tags
  Future<List<CourseEntity>> getCoursesByTags(List<String> tags);

  /// Get course progress for user
  Future<double> getCourseProgress(String userId, String courseId);

  /// Update course progress
  Future<void> updateCourseProgress(String userId, String courseId, String moduleId, String lessonId);

  /// Get user's enrolled courses with progress
  Future<List<CourseEntity>> getUserEnrolledCourses(String userId);

  /// Get recommended courses for user
  Future<List<CourseEntity>> getRecommendedCourses(String userId);

  /// Rate a course
  Future<void> rateCourse(String userId, String courseId, double rating);

  /// Get course ratings
  Future<Map<String, dynamic>> getCourseRatings(String courseId);

  /// Create new course (for instructors)
  Future<void> createCourse(CourseEntity course);

  /// Update existing course
  Future<void> updateCourse(CourseEntity course);

  /// Delete course
  Future<void> deleteCourse(String courseId);

  /// Get course analytics
  Future<Map<String, dynamic>> getCourseAnalytics(String courseId);
}