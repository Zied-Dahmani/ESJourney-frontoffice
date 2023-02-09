import 'package:esjourney/data/models/user_model.dart';

abstract class UserState
//    extends Equatable
{}

class UserInitial extends UserState {
  //@override
  //List<Object?> get props =>[];
}

class UserLoadInProgress extends UserState {
  //@override
  //List<Object?> get props =>[];
}

class UserLogInSuccess extends UserState {
  final User user;
  UserLogInSuccess(this.user);

  /*List<Object> get props => [user];

  Map<String, dynamic> toMap() {
    return {'user': user};
  }

  static UserLogInSuccess? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserLogInSuccess(map['user']);
  }

  String toJson() => json.encode(toMap());
  static UserLogInSuccess? fromJson(String source) =>
      fromMap(json.decode(source));*/
}

class UserLogOutSuccess extends UserState {
  //@override
  //List<Object?> get props =>[];
}

class UserIsFailure extends UserState {
  final String error;
  UserIsFailure(this.error);

//@override
//List<Object?> get props =>[];
}
