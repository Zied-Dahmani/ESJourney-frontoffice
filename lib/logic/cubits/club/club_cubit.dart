import 'dart:async';
import 'dart:developer' as developer;
import 'package:esjourney/data/models/club_model.dart';
import 'package:esjourney/data/repositories/club/club_repository.dart';
import 'package:esjourney/logic/cubits/club/club_state.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClubCubit extends Cubit<ClubState> {
  ClubCubit(this._connectivityCubit) : super(ClubLoadInProgress()) {
    init();
  }

  final _clubRepository = ClubRepository();
  final ConnectivityCubit _connectivityCubit;
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

  @override
  Future<void> close() {
    _connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
