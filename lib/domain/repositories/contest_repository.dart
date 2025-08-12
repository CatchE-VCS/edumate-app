import 'package:edumate/domain/entities/contest_entity.dart';

/// Repository interface for contest data operations
abstract class ContestRepository {
  /// Get all contests
  Future<List<ContestEntity>> getAllContests();

  /// Get contest by ID
  Future<ContestEntity?> getContestById(String contestId);

  /// Get upcoming contests
  Future<List<ContestEntity>> getUpcomingContests({int limit = 20});

  /// Get ongoing contests
  Future<List<ContestEntity>> getOngoingContests();

  /// Get past contests
  Future<List<ContestEntity>> getPastContests({int limit = 50});

  /// Get contests by platform
  Future<List<ContestEntity>> getContestsByPlatform(String platform);

  /// Search contests by name or description
  Future<List<ContestEntity>> searchContests(String query, {
    int limit = 20,
    ContestType? type,
    ContestDifficulty? difficulty,
  });

  /// Register user for contest
  Future<void> registerForContest(String userId, String contestId);

  /// Unregister user from contest
  Future<void> unregisterFromContest(String userId, String contestId);

  /// Check if user is registered for contest
  Future<bool> isUserRegistered(String userId, String contestId);

  /// Get user's registered contests
  Future<List<ContestEntity>> getUserRegisteredContests(String userId);

  /// Submit solution for contest problem
  Future<void> submitSolution(String userId, String contestId, String problemId, String solution);

  /// Get contest leaderboard
  Future<List<Map<String, dynamic>>> getContestLeaderboard(String contestId);

  /// Get user's contest history
  Future<List<Map<String, dynamic>>> getUserContestHistory(String userId);

  /// Get contest statistics
  Future<Map<String, dynamic>> getContestStats(String contestId);

  /// Create new contest (for admins)
  Future<void> createContest(ContestEntity contest);

  /// Update existing contest
  Future<void> updateContest(ContestEntity contest);

  /// Delete contest
  Future<void> deleteContest(String contestId);

  /// Get contest problems
  Future<List<ProblemEntity>> getContestProblems(String contestId);

  /// Get problem by ID
  Future<ProblemEntity?> getProblemById(String problemId);

  /// Add problem to contest
  Future<void> addProblemToContest(String contestId, ProblemEntity problem);

  /// Remove problem from contest
  Future<void> removeProblemFromContest(String contestId, String problemId);
}