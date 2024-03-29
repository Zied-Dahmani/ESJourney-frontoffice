import 'package:esjourney/data/models/user_model.dart';
import 'package:esjourney/data/repositories/chat/chat_service.dart';
import 'package:esjourney/presentation/screens/curriculum/chat/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key,
    required this.receiver,
    required this.myUsername,
    required this.token})
      : super(key: key);
  final User receiver;
  final String myUsername;
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
      twoDAvatar: widget.receiver.twoDAvatar!,
      currentUsername: widget.myUsername,
      msg: text,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 400,
        ),
      ),
      username: widget.myUsername,
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });

    socketService.emit('private-message',
        {'from': widget.myUsername, 'to': widget.receiver.username, 'message': text});
  }

  void _listenMessage(dynamic payload) {
    ChatMessage message = ChatMessage(
      twoDAvatar: widget.receiver.twoDAvatar!,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
      username: payload["from"],
      msg: payload["message"],
      currentUsername: widget.myUsername,
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  void _listenIsTyping(dynamic payload) {
    if (payload["isTyping"]) {
      setState(() {
        _isWriting = true;
      });
    } else {
      setState(() {
        _isWriting = false;
      });
    }
  }

  void sendTypingEvent(bool isTyping) {
    socketService.emit('is-typing', {
      'from': widget.myUsername,
      'to': widget.receiver.username,
      'isTyping': isTyping,
    });
  }

  @override
  void initState() {
    super.initState();
    socketService = Provider.of<SocketService>(context, listen: false);
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService.socket.on("private-message", _listenMessage);
    socketService.socket.on("is-typing", _listenIsTyping);
    _chargeHistory(widget.receiver.username, widget.token);
  }

  @override
  void dispose() {
    super.dispose();
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService.socket.off("private-message");
    socketService.socket.off("is-typing");
  }

  void _chargeHistory(String userID, String token) async {
    List<dynamic> messages = await chatService.getChat(userID, token);

    final history = messages.map((m) =>
        ChatMessage(
          twoDAvatar: widget.receiver.twoDAvatar!,
          currentUsername: widget.myUsername,
          animationController: AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 0),
          )
            ..forward(),
          msg: m.message,
          username: m.from,
        ));
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget userInput() {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 32,
              color: const Color(0xFF087949).withOpacity(0.08),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
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
                              _handleSubmit(text);
                              sendTypingEvent(false);
                            },
                            onChanged: (String msg) {
                              if (msg.isEmpty) {
                                sendTypingEvent(false);
                              } else {
                                sendTypingEvent(true);
                              }
                            },
                            focusNode: _focusNode,
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
                      IconButton(
                        onPressed: () {
                          if (_textController.text.isNotEmpty) {
                            _handleSubmit(_textController.text.trim());
                            sendTypingEvent(false);
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
      );
    }

    String millisecondsToString() {
      final now = DateTime.now();
      final lastSeenDate = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.receiver.lastSeen));
      final difference = now.difference(lastSeenDate);
      final differenceInMinutes = difference.inMinutes;
      final differenceInHours = difference.inHours;
      final differenceInDays = difference.inDays;
      if (widget.receiver.online!) {
        return 'Online';
      } else if (differenceInMinutes < 60) {
        return '$differenceInMinutes minutes ago';
      } else if (differenceInHours < 24) {
        return '$differenceInHours hours ago';
      } else if (differenceInDays < 7) {
        return '$differenceInDays days ago';
      } else {
        return 'A long time ago';
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB4A5A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
          {
            _isWriting = false,
            sendTypingEvent(false),
            Navigator.of(context).pop(),
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: Image
                  .network(widget.receiver.twoDAvatar!)
                  .image,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiver.username,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                if(!_isWriting)
                Text(
                  millisecondsToString(),
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                )
                else
                  const Text(
                    'typing...',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
              ],
            )
          ],
        ),
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
          userInput(),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String msg;
  final String username;
  final String currentUsername;
  final AnimationController animationController;
  final String? twoDAvatar;

  const ChatMessage({
    Key? key,
    required this.msg,
    required this.username,
    required this.animationController,
    required this.currentUsername,
    this.twoDAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.easeInOut),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 4, right: 4, bottom: 5),
          child: Row(
            mainAxisAlignment: username == currentUsername
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (username != currentUsername) ...[
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(context: context, builder: (context) {
                      return Container(
                      );
                    });
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    backgroundImage: Image
                        .network(twoDAvatar!)
                        .image,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              messageBox(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget messageBox(BuildContext ctx) {
    return Flexible(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery
              .of(ctx)
              .size
              .width * 0.7,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF03738)
              .withOpacity(username == currentUsername ? 1 : 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          msg,
          softWrap: true,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: username == currentUsername ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
