import 'package:esjourney/data/models/challenges/submission/submission_model.dart';
import 'package:esjourney/data/providers/challenges/submission_data_provider.dart';
import 'package:esjourney/data/repositories/challenges/submission_repository_interface.dart';

import '../../../models/challenges/achievement/achievement_model.dart';
import '../../../models/user_model.dart';
import '../../../providers/challenges/achievement_data_provider.dart';
import 'achievement_repository_interface.dart';

class AchievementRepository implements IAchievementRepository {
  final AchievementDataProvider _achievementDataProvider =
      AchievementDataProvider();

  @override
  Future addAchievement(String token, String name) async {
    final result = await _achievementDataProvider.addAchievement(token, name);
    return result.statusCode == 201
        ? User.fromJson(result.data)
        : "Something went wrong";
  }
}
