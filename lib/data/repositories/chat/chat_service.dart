import 'package:esjourney/data/models/curriculum/message_model.dart';
import 'package:esjourney/data/providers/chat/chat_data_provider.dart';
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier {
  List<dynamic> messages = [];

  final ChatDataProvider _chatDataProvider = ChatDataProvider();

  Future<dynamic> getChat(String userID, String token) async {
    final result = await _chatDataProvider.getChat(token, userID);
    if (result.statusCode == 200) {
      messages = result.data.map((msg) => Message.fromJson(msg)).toList();
      notifyListeners();
      return messages;
    } else {
      return messages;
    }
  }

  Future<dynamic> getChatByGrade(String token) async {
    final result = await _chatDataProvider.getChatByGrade(token);
    if (result.statusCode == 200) {
      messages = result.data.map((msg) => Message.fromJson(msg)).toList();
      notifyListeners();
      return messages;
    } else {
      return messages;
    }
  }
}
