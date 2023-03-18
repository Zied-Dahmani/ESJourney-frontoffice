import 'dart:developer' as developer;

import 'package:esjourney/data/repositories/challenges/leaderboard_repository.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(LeaderboardInitial()){

    getLeaderboard();

  }

  final _leaderboardRepository = LeaderboardRepository();
  void changePeriod(int period) {
    if(state is LeaderboardSuccess){
      emit((state as LeaderboardSuccess).copyWith(period: period));
    }

  }
  Future<void> getLeaderboard() async {
    try {
      emit(LeaderboardLoadInProgress());
      final result = await _leaderboardRepository.getLeaderboard();

      if (result != null) {
        final usersList = List<dynamic>.from(result);

        // Sort the users by monthly score
        usersList.sort((a, b) => b.score.monthly.compareTo(a.score.monthly));

        // Take the top 10 users by monthly score
        final monthlyTop10 = usersList.take(10).toList();

        // Sort the users by weekly score
        usersList.sort((a, b) => b.score.weekly.compareTo(a.score.weekly));

        // Take the top 10 users by weekly score
        final weeklyTop10 = usersList.take(10).toList();

        // Sort the users by all-time score
        usersList.sort((a, b) => b.score.allTime.compareTo(a.score.allTime));

        // Take the top 10 users by all-time score
        final allTimeTop10 = usersList.take(10).toList();

        emit(LeaderboardSuccess(weeklyTop10, monthlyTop10, allTimeTop10,0));
      } else {
        emit(LeaderboardIsFailure("Error while getting data"));
      }
    } catch (e) {
      developer.log(e.toString(), name: 'error leaderboard');
      emit(LeaderboardIsFailure("Error while fetching data"));
    }
  }
}
