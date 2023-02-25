import 'dart:io';

import 'package:esjourney/chatest/chat_service.dart';
import 'package:esjourney/chatest/message_model.dart';
import 'package:esjourney/chatest/socket_service.dart';
import 'package:esjourney/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen(
      {Key? key, required this.receiver, required this.myId, required this.token})
      : super(key: key);
  final User receiver;
  final String myId;
  final String token;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;
  late SocketService socketService;
  late ChatService chatService;
  final List<ChatMessage> _messages = [];

  _handleSubmit(String text) {
    if (text.isEmpty) return;

    _textController.clear();

    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      currentUserId: widget.myId,
      msg: text,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 400,
        ),
      ), uid: widget.receiver.id,
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });

    socketService.emit('private-message', {
      'from': widget.myId,
      'to': widget.receiver.id,
      'message': text
    });

  }

  @override
  void initState() {
    super.initState();
    socketService = Provider.of<SocketService>(context, listen: false);
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService.socket.on("private-message", _listenMessage);
    _chargeHistory(widget.receiver.id,widget.token);
  }

  void _listenMessage(dynamic payload) {
    ChatMessage message = ChatMessage(
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
      uid: payload["from"],
      msg: payload["message"],
      currentUserId: widget.myId,
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService.socket.off("private-message");
  }

  void _chargeHistory(String userID,String token) async {
    List<Message> messages = await chatService.getMessages(userID,token);

    final history = messages.map((m) => ChatMessage(
      currentUserId: widget.myId,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 0),
      )..forward(),
      msg: m.message,
      uid: m.from,
    ));
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userTo = widget.receiver;

    Widget inputChat(User userTo) {
      return SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                    controller: _textController,
                    onSubmitted: (text) {
                      _handleSubmit(text);
                    },
                    onChanged: (String msg) {
                      if (msg.trim().isNotEmpty) {
                        setState(() {
                          _isWriting = true;
                        });
                      } else {
                        setState(() {
                          _isWriting = false;
                        });
                      }
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: "Enviar mensagem",
                    ),
                    focusNode: _focusNode),
              ),
              //botao enviar

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Platform.isIOS
                    ? CupertinoButton(
                  onPressed: _isWriting
                      ? () => _handleSubmit(
                      _textController.text.trim())
                      : null,
                  child: const Text("Enviar"),
                )
                    : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(Icons.send),
                      onPressed: _isWriting
                          ? () => _handleSubmit(
                          _textController.text.trim())
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB4A5A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: Image.network(widget.receiver.twoDAvatar!).image,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiver.username,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  widget.receiver.online ? "Online" : "Offline",
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_phone, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: _messages.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            ),
          ),
          const Divider(
            height: 1,
          ),
          SizedBox(
            height: 50,
            child: inputChat(userTo),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String msg;
  final String uid;
  final String currentUserId;
  final AnimationController animationController;

  const ChatMessage({
    Key? key,
    required this.msg,
    required this.uid,
    required this.animationController,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.easeInOut),
        child: Container(
          child: uid == currentUserId ? _myMessage() : _noMyMesssage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(right: 5, bottom: 5, left: 50),
            decoration: BoxDecoration(
                color: const Color(0xff060a37),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  msg,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Text(
        //     createdAt?.toString().substring(0, 16) ??
        //         DateTime.now().toString().substring(0, 16),
        //     style: TextStyle(color: Colors.grey, fontSize: 10))
      ],
    );
  }

  Widget _noMyMesssage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(left: 5, bottom: 5, right: 50),
            decoration: BoxDecoration(
                color: const Color(0xffE4E5E8),
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              msg,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Text(createdAt.toString().substring(0, 16),
        //     style: TextStyle(color: Colors.grey, fontSize: 10))
      ],
    );
  }
}
