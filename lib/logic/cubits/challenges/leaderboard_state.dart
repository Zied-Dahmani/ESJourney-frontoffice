

import 'package:equatable/equatable.dart';

abstract class LeaderboardState extends Equatable {}

class LeaderboardInitial extends LeaderboardState {
  @override
  // TODO: implement props
  List<Object?> get props => [] ;
}

class LeaderboardLoadInProgress extends LeaderboardState {
  @override
  // TODO: implement props
  List<Object?> get props => [] ;
}

class LeaderboardSuccess extends LeaderboardState {

  final List<dynamic> weeklyUsers;
  final List<dynamic> monthlyUsers;
  final List<dynamic> allTimeUsers;
  final int period ;

  LeaderboardSuccess( this.weeklyUsers, this.monthlyUsers, this.allTimeUsers, this.period);
  LeaderboardSuccess copyWith({int ? period}) {
    return LeaderboardSuccess(
       weeklyUsers,
        monthlyUsers,
        allTimeUsers,
        period ?? this.period,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [weeklyUsers, monthlyUsers, allTimeUsers, period] ;
}

class LeaderboardIsFailure extends LeaderboardState {
  final String error;

  LeaderboardIsFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [] ;
}
