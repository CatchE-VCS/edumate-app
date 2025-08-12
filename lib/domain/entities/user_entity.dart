/// User entity representing core user data
class UserEntity {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final int coins;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final List<String> enrolledCourses;
  final List<String> completedCourses;
  final Map<String, dynamic> preferences;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.coins = 0,
    required this.createdAt,
    this.lastLoginAt,
    this.enrolledCourses = const [],
    this.completedCourses = const [],
    this.preferences = const {},
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    int? coins,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    List<String>? enrolledCourses,
    List<String>? completedCourses,
    Map<String, dynamic>? preferences,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      coins: coins ?? this.coins,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      completedCourses: completedCourses ?? this.completedCourses,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, displayName: $displayName)';
  }
}