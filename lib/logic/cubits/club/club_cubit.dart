import 'dart:async';
import 'dart:developer' as developer;
import 'package:esjourney/data/models/club/club/club_model.dart';
import 'package:esjourney/logic/cubits/club/club_state.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/dynamic_link.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';

class ClubCubit extends Cubit<ClubState> {
  ClubCubit(this._connectivityCubit, this._userCubit, this._clubRepository) : super(ClubLoadInProgress()) {
    initDynamicLink();
  }

  final _connectivityCubit, _clubRepository, _userCubit;
  StreamSubscription? _connectivityStreamSubscription;

  bool isFirstTime = true;
  late List<Club> _clubs;
  late String _clubId;

  initDynamicLink() async {
    _clubId = await DynamicLink().init();
    if (_clubId != '') {
      init();
      isFirstTime = false;
    }
  }

  void init() {
    if (isFirstTime) {
      if (_connectivityCubit.state is ConnectivityConnectSuccess) {
        getAllClubs();
      } else {
        emit(ClubLoadFailure(kcheckInternetConnection));
      }
      listen();
    }
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
          ? {_clubs = result.cast<Club>(), emit(ClubLoadSuccess(_clubs))}
          : emit(ClubLoadFailure(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch getAllClubs');
      emit(ClubLoadFailure(kcheckInternetConnection));
    }
  }

  Club? getClub() {
    try {
      return _clubs.where((club) => club.id == _clubId).first;
    } catch (e) {
      developer.log(e.toString(), name: 'Catch getClub');
      return null;
    }
  }

  Future<void> shareClub(Club club, String linkUrl) async {
    await FlutterShare.share(
        title: club.name,
        text: club.name,
        linkUrl: linkUrl,
        chooserTitle: club.name);
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
