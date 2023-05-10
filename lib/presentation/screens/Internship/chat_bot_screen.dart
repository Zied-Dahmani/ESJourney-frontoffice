import 'dart:async';
import 'dart:convert';

import 'package:esjourney/presentation/screens/curriculum/chat/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../widgets/drawer_icon.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();

  final List<ChatMessage> _messages = [];
  bool _isTyping = false; // Add this variable

  void _addMessage(String message, bool isUser) {
    final newMessage = ChatMessage(
      twoDAvatar:
      "https://raw.githubusercontent.com/ZiedDaedly/ESJourney-frontoffice/main/assets/images/app_logo.png",
      currentUsername: isUser ? "Chatbot" : "User",
      msg: message,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 400,
        ),
      ),
      username: "Chatbot",
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    /*setState(() {
      _messages.add(newMessage);
    });*/
  }

  Future<String> getChatbotResponse(String message) async {
    setState(() {
      _isTyping = true; // Set isTyping to true before making the API call
    });
//change ip address to your ip address
    final response = await http.post(
      Uri.parse('http://192.168.0.2:9090/chatbot/chat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _isTyping = false; // Set isTyping to true before making the API call
      });
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get response from chatbot API');
    }
  }

  void _handleSubmitted(String text) {
    getChatbotResponse(text).then((value) => _addMessage(value, false));
    _textController.clear();
    _addMessage(text, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assistant'),
        leading: DrawerIcon(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: TextField(
                              style: const TextStyle(
                                color: Color(0xFF3C4046),
                              ),
                              controller: _textController,
                              onSubmitted: (text) {
                                _handleSubmitted(text);
                              },
                              decoration: const InputDecoration(
                                hintText: "Type message",
                                hintStyle: TextStyle(
                                  color: Color(0xFFA0A5BD),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        _isTyping
                            ? Text('isTyping...')
                            : IconButton(
                          onPressed: () {
                            if (_textController.text.isNotEmpty) {
                              _handleSubmitted(_textController.text);
                            } else {
                              null;
                            }
                          },
                          icon: const Icon(Icons.send_outlined,
                              color: Color(0xFFF03738)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}