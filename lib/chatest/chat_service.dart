import 'dart:convert';

import 'package:esjourney/chatest/message_model.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  List<Message> messages = [];

  Future<List<Message>> getMessages(String userID, String token) async {
    final response = await http.get(Uri.parse('${kbaseUrl}messages/$userID'),
        headers: {'Content-Type': 'application/json', 'jwt': token});

    final messagesResponse = messagesResponseFromJson(response.body);
    messages.addAll(messagesResponse.messages);

    return messagesResponse.messages;
  }
}

MessagesResponse messagesResponseFromJson(String str) =>
    MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) =>
    json.encode(data.toJson());

class MessagesResponse {
  MessagesResponse({
    required this.ok,
    required this.messages,
  });

  bool ok;
  List<Message> messages;

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      MessagesResponse(
        ok: json["ok"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}
