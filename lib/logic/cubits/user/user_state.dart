import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:esjourney/data/models/challenges/achievement/achievement_model.dart';
import 'package:esjourney/data/models/user_model.dart';

import '../../../data/models/challenges/score/score_model.dart';

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

  @override
  List<Object> get props => [user];

  Map<String, dynamic> toMap() {
    return {
      '_id': user.id,
      'email': user.email,
      'username': user.username,
      'password': user.password,
      'grade': user.grade,
      'token': user.token!,
      'courses': '',
      'events': '',
      'coins': user.coins,
      'threeDAvatar': user.threeDAvatar,
      'twoDAvatar': user.twoDAvatar,
      'online': user.online,
      'fullName': user.fullName,
      'lastSeen': user.lastSeen,
      'walletAddress': user.walletAddress,
      'privateKey': user.privateKey,
      'score': user.score,
      'achievement': user.achievement,
      'achievements': user.achievements,

    };
  }

  static UserLogInSuccess? fromMap(Map<String, dynamic> map) {
    return UserLogInSuccess(User(

      id: map['_id'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
      grade: map['grade'],
      coins: map['coins'],
      token: map['token'],
      threeDAvatar: map['threeDAvatar'],
      twoDAvatar: map['twoDAvatar'],
      courses: [],
      events: [],
      online: map['online'],
      fullName: map['fullName'],
      lastSeen: map['lastSeen'],
      walletAddress: map['walletAddress'],
      privateKey: map['privateKey'],
      score: Score.fromJson(map['score']),
      achievement: Achievement.fromJson(map['achievement']),
      achievements: List<Achievement>.from(map['achievements']?.map((x) => Achievement.fromJson(x))),


    ));
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
