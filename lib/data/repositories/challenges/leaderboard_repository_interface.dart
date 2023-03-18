import 'package:esjourney/data/models/challenges/leaderboard/leaderboard_res.dart';

abstract class ILeaderboardRepository {
  Future<dynamic> getLeaderboard();
}
