import 'dart:async';
import 'dart:developer' as developer;
import 'package:esjourney/data/models/club_event_model.dart';
import 'package:esjourney/data/repositories/club_event/club_event_repository.dart';
import 'package:esjourney/logic/cubits/club_event/club_event_state.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClubEventCubit extends Cubit<ClubEventState> {
  ClubEventCubit(this._connectivityCubit) : super(ClubEventLoadInProgress()) {
    init();
  }

  final _clubEventRepository = ClubEventRepository();
  final ConnectivityCubit _connectivityCubit;
  StreamSubscription? _connectivityStreamSubscription;

  void init() {
    if (_connectivityCubit.state is ConnectivityConnectSuccess) {
      getAllClubEvents();
    } else {
      emit(ClubEventLoadFailure(kcheckInternetConnection));
    }
    listen();
  }

  StreamSubscription<ConnectivityState> listen() {
    return _connectivityStreamSubscription =
        _connectivityCubit.stream.listen((connectivityState) {
          if (connectivityState is ConnectivityConnectSuccess &&
              state is! ClubEventLoadSuccess) {
            getAllClubEvents();
          } else if (connectivityState is ConnectivityDisconnectSuccess &&
              state is ClubEventLoadInProgress) {
            emit(ClubEventLoadFailure(kcheckInternetConnection));
          }
        });
  }

  Future<void> getAllClubEvents() async {
    try {
      final result = await _clubEventRepository.getAllClubEvents();
      result != null
          ? emit(ClubEventLoadSuccess(result.cast<ClubEvent>()))
          : emit(ClubEventLoadFailure(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch getAllClubEvents');
      emit(ClubEventLoadFailure(kcheckInternetConnection));
    }
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
