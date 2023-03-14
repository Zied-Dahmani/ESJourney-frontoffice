import 'dart:convert';
import 'package:esjourney/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

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
      'id':user.id,
      'email': user.email,
      'username': user.username,
      'password': user.password,
      'token': user.token,
      'fullName': user.fullName,
      'image': user.image,
    };
  }

  static UserLogInSuccess? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserLogInSuccess(User(
        id: map['id'],
        email: map['email'],
        username: map['username'],
        password: map['password'],
        token: map['token'],
        fullName: map['fullName'],
        image: map['image']));
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
