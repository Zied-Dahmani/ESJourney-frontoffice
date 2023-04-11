import 'dart:async';
import 'dart:developer' as developer;
import 'package:esjourney/data/models/club/event/club_event_model.dart';
import 'package:esjourney/data/models/club/event/club_event_type_enum.dart';
import 'package:esjourney/data/models/club/event/ticket_model.dart';
import 'package:esjourney/logic/cubits/club_event/club_event_state.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ClubEventCubit extends Cubit<ClubEventState> {
  ClubEventCubit(this._connectivityCubit, this._clubRepository)
      : super(ClubEventLoadInProgress()) {
    init();
  }

  final _connectivityCubit, _clubRepository;
  StreamSubscription? _connectivityStreamSubscription;

  bool _isFirstTime = true;
  List<ClubEvent> _allClubEventsList = [];
  Ticket? _ticket;
  int? _ticketIndex;
  get ticket => _ticket;
  get ticketIndex => _ticketIndex;

  void init() {
    if (_connectivityCubit.state is ConnectivityConnectSuccess) {
      getAllClubEvents();
    } else {
      emit(ClubEventLoadFailure(kcheckInternetConnection));
    }
    if(_isFirstTime) {
      _isFirstTime = false;
      listen();
    }
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
      final result = await _clubRepository.getAllClubEvents();
      if (result != null) {
        _allClubEventsList = result.cast<ClubEvent>();
        emit(ClubEventLoadSuccess(_allClubEventsList));
      } else {
        emit(ClubEventLoadFailure(kbadRequest));
      }
    } catch (e) {
      developer.log(e.toString(), name: 'Catch getAllClubEvents');
      emit(ClubEventLoadFailure(kcheckInternetConnection));
    }
  }

  Future<void> launchGoogleMaps(double latitude, double longitude) async =>
      MapsLauncher.launchCoordinates(latitude, longitude);

  void filter(ClubEventType clubEventType) {
    if (clubEventType == ClubEventType.all) {
      emit(ClubEventLoadSuccess(_allClubEventsList));
    } else {
      var list = <ClubEvent>[];
      _allClubEventsList.forEach((ClubEvent clubEvent) {
        if (clubEvent.type == clubEventType) {
          list.add(clubEvent);
        }
      });
      emit(ClubEventLoadSuccess(list));
    }
  }

  int remainingTickets(ClubEvent clubEvent, String type) {
    int count = 0;
    for (var i = 0 ; i < clubEvent.tickets.length; i++) {
      if (clubEvent.tickets[i].type == type && !clubEvent.tickets[i].booked) {
        _ticket ??= clubEvent.tickets[i];
        _ticketIndex ??= i;
        count++;
      }
    }
    return count;
  }

  Future<bool> bookEvent(String token, String clubId, int ticketIndex) async {
    try {
      return await _clubRepository.bookEvent(token, clubId, ticketIndex);
    } catch (e) {
      developer.log(e.toString(), name: 'Catch bookEvent');
      return false;
    }
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
