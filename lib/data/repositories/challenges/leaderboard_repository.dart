

import 'package:esjourney/data/models/challenges/leaderboard/leaderboard_res.dart';
import 'package:esjourney/data/models/user_model.dart';
import 'package:esjourney/data/providers/challenges/leaderboard_data_provider.dart';
import 'package:esjourney/data/repositories/challenges/leaderboard_repository_interface.dart';



class LeaderboardRepository implements ILeaderboardRepository {
  final LeaderboardDataProvider _leaderboardDataProvider = LeaderboardDataProvider();


  @override
  Future <dynamic> getLeaderboard() async {

    final result = await _leaderboardDataProvider.getLeaderBoard();
    return result.statusCode == 200
        ? result.data.map((leaderboardRes) => LeaderboardRes.fromJson(leaderboardRes)).toList()
        : null;


  }
}
