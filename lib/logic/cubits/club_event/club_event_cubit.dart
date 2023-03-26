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
  ClubEventCubit(this._connectivityCubit, this._clubRepository) : super(ClubEventLoadInProgress()) {
    init();
  }

  final _connectivityCubit,_clubRepository;
  StreamSubscription? _connectivityStreamSubscription;

  late final _allClubEventsList;
  Ticket? _ticket;
  get ticket => _ticket;

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

  Future<void> launchGoogleMaps(double latitude, double longitude) async => MapsLauncher.launchCoordinates(latitude, longitude);

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


  double remainingTickets(ClubEvent clubEvent, String type)
  {
    double count = 0.0;
    clubEvent.tickets.forEach((ticket) {
      if(ticket.type == type && !ticket.booked) {
        _ticket ??= ticket;
        count ++;
      }
    });
    return count;
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
