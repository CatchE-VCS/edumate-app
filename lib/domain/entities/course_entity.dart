/// Course entity representing educational course data
class CourseEntity {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String? thumbnailUrl;
  final Duration duration;
  final List<ModuleEntity> modules;
  final CourseLevel level;
  final List<String> tags;
  final double rating;
  final int enrollmentCount;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    this.thumbnailUrl,
    required this.duration,
    this.modules = const [],
    this.level = CourseLevel.beginner,
    this.tags = const [],
    this.rating = 0.0,
    this.enrollmentCount = 0,
    this.isPublished = false,
    required this.createdAt,
    required this.updatedAt,
  });

  CourseEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? instructor,
    String? thumbnailUrl,
    Duration? duration,
    List<ModuleEntity>? modules,
    CourseLevel? level,
    List<String>? tags,
    double? rating,
    int? enrollmentCount,
    bool? isPublished,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      modules: modules ?? this.modules,
      level: level ?? this.level,
      tags: tags ?? this.tags,
      rating: rating ?? this.rating,
      enrollmentCount: enrollmentCount ?? this.enrollmentCount,
      isPublished: isPublished ?? this.isPublished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Calculate completion percentage
  double get completionPercentage {
    if (modules.isEmpty) return 0.0;
    final completedModules = modules.where((module) => module.isCompleted).length;
    return completedModules / modules.length;
  }

  /// Get total number of lessons across all modules
  int get totalLessons {
    return modules.fold(0, (total, module) => total + module.lessons.length);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CourseEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CourseEntity(id: $id, title: $title, instructor: $instructor)';
  }
}

/// Course module entity
class ModuleEntity {
  final String id;
  final String title;
  final String description;
  final int orderIndex;
  final List<LessonEntity> lessons;
  final bool isCompleted;
  final Duration estimatedDuration;

  const ModuleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.orderIndex,
    this.lessons = const [],
    this.isCompleted = false,
    required this.estimatedDuration,
  });

  ModuleEntity copyWith({
    String? id,
    String? title,
    String? description,
    int? orderIndex,
    List<LessonEntity>? lessons,
    bool? isCompleted,
    Duration? estimatedDuration,
  }) {
    return ModuleEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      orderIndex: orderIndex ?? this.orderIndex,
      lessons: lessons ?? this.lessons,
      isCompleted: isCompleted ?? this.isCompleted,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
    );
  }

  /// Calculate module completion percentage
  double get completionPercentage {
    if (lessons.isEmpty) return 0.0;
    final completedLessons = lessons.where((lesson) => lesson.isCompleted).length;
    return completedLessons / lessons.length;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ModuleEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Course lesson entity
class LessonEntity {
  final String id;
  final String title;
  final String description;
  final LessonType type;
  final String? videoUrl;
  final String? content;
  final Duration duration;
  final int orderIndex;
  final bool isCompleted;
  final bool isLocked;

  const LessonEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.videoUrl,
    this.content,
    required this.duration,
    required this.orderIndex,
    this.isCompleted = false,
    this.isLocked = false,
  });

  LessonEntity copyWith({
    String? id,
    String? title,
    String? description,
    LessonType? type,
    String? videoUrl,
    String? content,
    Duration? duration,
    int? orderIndex,
    bool? isCompleted,
    bool? isLocked,
  }) {
    return LessonEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      videoUrl: videoUrl ?? this.videoUrl,
      content: content ?? this.content,
      duration: duration ?? this.duration,
      orderIndex: orderIndex ?? this.orderIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LessonEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum CourseLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

enum LessonType {
  video,
  text,
  quiz,
  assignment,
  interactive,
}