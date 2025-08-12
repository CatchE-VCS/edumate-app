/// Contest entity representing programming contest data
class ContestEntity {
  final String id;
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final ContestType type;
  final ContestStatus status;
  final String? platform;
  final String? url;
  final List<String> participants;
  final int maxParticipants;
  final List<ProblemEntity> problems;
  final Map<String, dynamic> rules;
  final ContestDifficulty difficulty;

  const ContestEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.status,
    this.platform,
    this.url,
    this.participants = const [],
    this.maxParticipants = 0,
    this.problems = const [],
    this.rules = const {},
    this.difficulty = ContestDifficulty.medium,
  });

  ContestEntity copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    ContestType? type,
    ContestStatus? status,
    String? platform,
    String? url,
    List<String>? participants,
    int? maxParticipants,
    List<ProblemEntity>? problems,
    Map<String, dynamic>? rules,
    ContestDifficulty? difficulty,
  }) {
    return ContestEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      status: status ?? this.status,
      platform: platform ?? this.platform,
      url: url ?? this.url,
      participants: participants ?? this.participants,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      problems: problems ?? this.problems,
      rules: rules ?? this.rules,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  /// Get contest duration
  Duration get duration => endTime.difference(startTime);

  /// Check if contest is currently active
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  /// Check if contest has ended
  bool get hasEnded => DateTime.now().isAfter(endTime);

  /// Check if contest hasn't started yet
  bool get hasNotStarted => DateTime.now().isBefore(startTime);

  /// Get time remaining until contest starts or ends
  Duration get timeRemaining {
    final now = DateTime.now();
    if (hasNotStarted) {
      return startTime.difference(now);
    } else if (isActive) {
      return endTime.difference(now);
    } else {
      return Duration.zero;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContestEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ContestEntity(id: $id, name: $name, status: $status)';
  }
}

/// Problem entity for contest problems
class ProblemEntity {
  final String id;
  final String title;
  final String description;
  final ProblemDifficulty difficulty;
  final List<String> tags;
  final int points;
  final Duration timeLimit;
  final int memoryLimit;
  final List<TestCaseEntity> testCases;
  final String? solutionTemplate;

  const ProblemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    this.tags = const [],
    required this.points,
    required this.timeLimit,
    required this.memoryLimit,
    this.testCases = const [],
    this.solutionTemplate,
  });

  ProblemEntity copyWith({
    String? id,
    String? title,
    String? description,
    ProblemDifficulty? difficulty,
    List<String>? tags,
    int? points,
    Duration? timeLimit,
    int? memoryLimit,
    List<TestCaseEntity>? testCases,
    String? solutionTemplate,
  }) {
    return ProblemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      points: points ?? this.points,
      timeLimit: timeLimit ?? this.timeLimit,
      memoryLimit: memoryLimit ?? this.memoryLimit,
      testCases: testCases ?? this.testCases,
      solutionTemplate: solutionTemplate ?? this.solutionTemplate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProblemEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Test case entity for problem verification
class TestCaseEntity {
  final String input;
  final String expectedOutput;
  final bool isHidden;

  const TestCaseEntity({
    required this.input,
    required this.expectedOutput,
    this.isHidden = false,
  });

  TestCaseEntity copyWith({
    String? input,
    String? expectedOutput,
    bool? isHidden,
  }) {
    return TestCaseEntity(
      input: input ?? this.input,
      expectedOutput: expectedOutput ?? this.expectedOutput,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TestCaseEntity && 
           other.input == input && 
           other.expectedOutput == expectedOutput;
  }

  @override
  int get hashCode => Object.hash(input, expectedOutput);
}

enum ContestType {
  individual,
  team,
  hackathon,
  educational,
}

enum ContestStatus {
  upcoming,
  ongoing,
  finished,
  cancelled,
}

enum ContestDifficulty {
  easy,
  medium,
  hard,
  expert,
}

enum ProblemDifficulty {
  easy,
  medium,
  hard,
}