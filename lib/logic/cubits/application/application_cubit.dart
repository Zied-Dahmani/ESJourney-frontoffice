import 'dart:async';
import 'dart:developer' as developer;
import 'package:esjourney/data/models/application_model.dart';
import 'package:esjourney/logic/cubits/application/application_state.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit(this._connectivityCubit, this._clubRepository)
      : super(ApplicationLoadInProgress()) {
    init();
  }

  final _connectivityCubit, _clubRepository;
  StreamSubscription? _connectivityStreamSubscription;
  List<Application> _allApplicationsList=[];

  void init() {
    if (_connectivityCubit.state is ConnectivityConnectSuccess) {
      getAllApplications();
    } else {
      emit(ApplicationLoadFailure(kcheckInternetConnection));
    }
    listen();
  }

  StreamSubscription<ConnectivityState> listen() {
    return _connectivityStreamSubscription =
        _connectivityCubit.stream.listen((connectivityState) {
      if (connectivityState is ConnectivityConnectSuccess &&
          state is! ApplicationLoadSuccess) {
        getAllApplications();
      } else if (connectivityState is ConnectivityDisconnectSuccess &&
          state is ApplicationLoadInProgress) {
        emit(ApplicationLoadFailure(kcheckInternetConnection));
      }
    });
  }

  Future<void> getAllApplications() async {
    try {
      final result = await _clubRepository.getAllApplications();
      if (result != null) {
        _allApplicationsList = result.cast<Application>();
        emit(ApplicationLoadSuccess(_allApplicationsList));
      } else {
        emit(ApplicationLoadFailure(kbadRequest));
      }
    } catch (e) {
      developer.log(e.toString(), name: 'Catch getAllApplications');
      emit(ApplicationLoadFailure(kcheckInternetConnection));
    }
  }

  String _clubName = 'All';

  void filter(clubName,isStart) {
    _clubName = clubName ?? _clubName;

    if (_clubName == 'All' && isStart ) {
      emit(ApplicationLoadSuccess(_allApplicationsList));
    } else {
      var list = <Application>[];
      _allApplicationsList.forEach((Application application) {
        if (application.club.name == _clubName || _clubName == 'All'  && isStart ) {
          list.add(application);
        }
        else if(application.club.name == _clubName || _clubName == 'All'  && application.dateTime.compareTo(DateTime.now()) > 0)
          {
            list.add(application);
          }
      });
      emit(ApplicationLoadSuccess(list));
    }
  }

  void filterWithDateTime() {
    var list = <Application>[];
      _allApplicationsList.forEach((Application application) {
        if ( ( application.club.name == _clubName || _clubName == 'All' ) && application.dateTime.compareTo(DateTime.now()) > 0) {
          list.add(application);
        }
      });
      emit(ApplicationLoadSuccess(list));
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
