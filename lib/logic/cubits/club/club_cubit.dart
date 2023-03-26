import 'dart:async';
import 'dart:developer' as developer;
import 'package:esjourney/data/models/club/club/club_model.dart';
import 'package:esjourney/logic/cubits/club/club_state.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClubCubit extends Cubit<ClubState> {
  ClubCubit(this._connectivityCubit,this._userCubit, this._clubRepository) : super(ClubLoadInProgress()) {
    init();
  }

  final _connectivityCubit,_clubRepository,_userCubit;
  StreamSubscription? _connectivityStreamSubscription;


  void init() {
    if (_connectivityCubit.state is ConnectivityConnectSuccess) {
      getAllClubs();
    } else {
      emit(ClubLoadFailure(kcheckInternetConnection));
    }
    listen();
  }

  StreamSubscription<ConnectivityState> listen() {
    return _connectivityStreamSubscription =
        _connectivityCubit.stream.listen((connectivityState) {
      if (connectivityState is ConnectivityConnectSuccess &&
          state is! ClubLoadSuccess) {
        getAllClubs();
      } else if (connectivityState is ConnectivityDisconnectSuccess &&
          state is ClubLoadInProgress) {
        emit(ClubLoadFailure(kcheckInternetConnection));
      }
    });
  }

  Future<void> getAllClubs() async {
    try {
      final result = await _clubRepository.getAllClubs();
      result != null
          ? emit(ClubLoadSuccess(result.cast<Club>()))
          : emit(ClubLoadFailure(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch getAllClubs');
      emit(ClubLoadFailure(kcheckInternetConnection));
    }
  }


  /*var isFirstTime = true;

  bool isLiked(isLiked,club) {
    final state = _userCubit.state;
    if(state is UserLogInSuccess)
      {
        if(isFirstTime) {
          isFirstTime = false;
          return club.likes.contains(state.user.id);
        }
        else{
          if(isLiked)
          {
            club.likes.remove(state.user.id);
            return false;
          }
          else
          {
            club.likes.add(state.user.id);
            return true;
          }
        }
      }
    return false;
  }
*/

  @override
  Future<void> close() {
    _connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
