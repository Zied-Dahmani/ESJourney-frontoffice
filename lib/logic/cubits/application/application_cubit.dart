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
  late final _allApplicationsList;

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

  void filter(String clubName) {
    if (clubName == "All") {
      emit(ApplicationLoadSuccess(_allApplicationsList));
    } else {
      var list = <Application>[];
      _allApplicationsList.forEach((Application application) {
        if (application.club.name == clubName) {
          list.add(application);
        }
      });
      emit(ApplicationLoadSuccess(list));
    }
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
