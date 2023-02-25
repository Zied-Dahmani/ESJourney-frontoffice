

import 'package:esjourney/chatest/message_model.dart';
import 'package:esjourney/data/models/user_model.dart';
import 'package:esjourney/data/providers/chat/chat_data_provider.dart';
import 'package:esjourney/data/repositories/chat/chat_repository_interface.dart';
import 'package:flutter/material.dart';

class ChatRepository with ChangeNotifier implements IChatRepository  {
  final ChatDataProvider _chatDataProvider = ChatDataProvider();

  @override
  Future getAllUsers(String token) async{
    final result = await _chatDataProvider.getAllUsers(token);
    return result.statusCode == 200
        ? result.data.map((user) => User.fromJson(user)).toList()
        : null;
  }

  @override
  Future getChat(String token, String id) async{
    final result = await _chatDataProvider.getChat(token, id);
    return result.statusCode == 200
        ? result.data.map((msg) => Message.fromJson(msg)).toList()
        : null;
  }
}
