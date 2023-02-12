import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:esjourney/data/models/user_model.dart';

abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadInProgress extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLogInSuccess extends UserState {
  final User user;

  UserLogInSuccess(this.user);

  List<Object> get props => [user];

  Map<String, dynamic> toMap() {
    return {
      'email': user.email,
      'username': user.username,
      'password': user.password,
      'grade': user.grade,
      'token': user.token,
      'courses': '',
      'coins': user.coins,
    };
  }

  static UserLogInSuccess? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserLogInSuccess(User(
        email: map['email'],
        username: map['username'],
        password: map['password'],
        grade: map['grade'],
        coins: map['coins'],
        token: map['token'],
        courses: []));
  }

  String toJson() => json.encode(toMap());

  static UserLogInSuccess? fromJson(String source) =>
      fromMap(json.decode(source));
}

class UserLogOutSuccess extends UserState {
  @override
  List<Object?> get props => [];
}

class UserIsFailure extends UserState {
  final String error;

  UserIsFailure(this.error);

  @override
  List<Object?> get props => [];
}
