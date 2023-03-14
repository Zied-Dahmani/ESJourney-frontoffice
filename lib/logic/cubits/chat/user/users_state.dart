abstract class UsersDataState {}

class UsersDataInitial extends UsersDataState {}

class UsersDataLoadInProgress extends UsersDataState {}

class UsersDataLoadingSuccess extends UsersDataState {
  final List<dynamic> users;

  UsersDataLoadingSuccess(this.users);
}

class UsersDataIsFailure extends UsersDataState {
  final String error;

  UsersDataIsFailure(this.error);
}
