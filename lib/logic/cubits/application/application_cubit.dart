import 'dart:async';
import 'dart:developer' as developer;
import 'package:esjourney/data/models/club/application/application_model.dart';
import 'package:esjourney/logic/cubits/application/application_state.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit(this._connectivityCubit, this._clubRepository, this._userCubit)
      : super(ApplicationLoadInProgress());

  final _connectivityCubit, _clubRepository, _userCubit;
  StreamSubscription? _connectivityStreamSubscription;
  List<Application> _allApplicationsList = [];
  bool _isFirstTime = true;

  Future<bool> apply(
      String token,
      String clubId,
      String? filePath,
      String fileName,
      String phoneNumber,
      String birthDate,
      String studyLevel,
      String speciality,
      List answers,
      String linkedInLink) async {
    try {
      return await _clubRepository.apply(
          token,
          clubId,
          filePath,
          fileName,
          phoneNumber,
          birthDate,
          studyLevel,
          speciality,
          answers,
          linkedInLink);
    } catch (e) {
      developer.log(e.toString(), name: 'Catch apply');
      return false;
    }
  }

  void init() {
    if (_connectivityCubit.state is ConnectivityConnectSuccess && _userCubit.state is UserLogInSuccess ) {
      getAllApplications(_userCubit.state.user.token);
    } else {
      emit(ApplicationLoadFailure(kcheckInternetConnection));
    }
    if (_isFirstTime) {
      _isFirstTime = false;
      listen();
    }
  }

  StreamSubscription<ConnectivityState> listen() {
    return _connectivityStreamSubscription =
        _connectivityCubit.stream.listen((connectivityState) {
      if (connectivityState is ConnectivityConnectSuccess &&
          state is! ApplicationLoadSuccess && _userCubit.state is UserLogInSuccess) {
        getAllApplications(_userCubit.state.user.token);
      } else if (connectivityState is ConnectivityDisconnectSuccess &&
          state is ApplicationLoadInProgress) {
        emit(ApplicationLoadFailure(kcheckInternetConnection));
      }
    });
  }

  Future<void> getAllApplications(String token) async {
    try {
      final result = await _clubRepository.getAllApplications(token);
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

  void filter(clubName, isStart) {
    _clubName = clubName ?? _clubName;

    if (_clubName == 'All' && isStart) {
      emit(ApplicationLoadSuccess(_allApplicationsList));
    } else {
      var list = <Application>[];
      _allApplicationsList.forEach((Application application) {
        if (application.club.name == _clubName ||
            _clubName == 'All' && isStart) {
          list.add(application);
        } else if (application.club.name == _clubName ||
            _clubName == 'All' && application.dateTime.compareTo(DateTime.now()) > 0  )    {
          list.add(application);
        }
      });
      emit(ApplicationLoadSuccess(list));
    }
  }

  void filterWithDateTime() {
    var list = <Application>[];
    _allApplicationsList.forEach((Application application) {
      if ((application.club.name == _clubName || _clubName == 'All') &&
          application.dateTime.compareTo(DateTime.now()) > 0) {
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
