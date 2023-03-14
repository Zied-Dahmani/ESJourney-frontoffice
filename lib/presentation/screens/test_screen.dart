import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:esjourney/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:tflite_flutter/tflite_flutter.dart';
class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _textController = TextEditingController();

  List<String> _messages = [];

  void _addMessage(String message) {
    setState(() {
      _messages.add(message);
    });
  }


  Future<String> getChatbotResponse(String message) async {
    final response = await http.post(
      Uri.parse('http://192.168.254.1:9090/chatbot/chat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get response from chatbot API');
    }
  }

  void _handleSubmitted(String text) {
    getChatbotResponse(text).then((value) => _addMessage(value));
    _textController.clear();
    _addMessage(text);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: _textController,

                    onSubmitted: _handleSubmitted,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Send a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

