import 'package:esjourney/data/models/user_model.dart';
import 'package:esjourney/data/repositories/chat/chat_service.dart';
import 'package:esjourney/presentation/screens/curriculum/chat/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen(
      {Key? key,
      required this.receiver,
      required this.myId,
      required this.token})
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
      twoDAvatar: widget.receiver.twoDAvatar,
      currentUserId: widget.myId,
      msg: text,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 400,
        ),
      ),
      uid: widget.receiver.id,
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });

    socketService.emit('private-message',
        {'from': widget.myId, 'to': widget.receiver.id, 'message': text});
  }

  void _listenMessage(dynamic payload) {
    ChatMessage message = ChatMessage(
      twoDAvatar: widget.receiver.twoDAvatar,
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
  void initState() {
    super.initState();
    socketService = Provider.of<SocketService>(context, listen: false);
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService.socket.on("private-message", _listenMessage);
    _chargeHistory(widget.receiver.id, widget.token);
  }

  @override
  void dispose() {
    super.dispose();
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService.socket.off("private-message");
  }

  void _chargeHistory(String userID, String token) async {
    List<dynamic> messages = await chatService.getMessages(userID, token);

    final history = messages.map((m) => ChatMessage(
          twoDAvatar: widget.receiver.twoDAvatar,
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
    Widget userInput() {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
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
                      const Icon(Icons.camera_alt_outlined,
                          color: Color(0xFFF03738)),
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
                            },
                            onChanged: (String msg) {
                              setState(() {
                                if (msg.trim().isNotEmpty) {
                                  _isWriting = true;
                                } else {
                                  _isWriting = false;
                                }
                              });
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
                      const Icon(Icons.mic, color: Color(0xFFF03738)),
                      IconButton(
                        onPressed: _isWriting
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
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
          userInput(),
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
  final String? twoDAvatar;

  const ChatMessage({
    Key? key,
    required this.msg,
    required this.uid,
    required this.animationController,
    required this.currentUserId, this.twoDAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.easeInOut),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
          child: Row(
            mainAxisAlignment: uid == currentUserId
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (uid != currentUserId) ...[
                 CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  backgroundImage: Image.network(twoDAvatar!).image,
                ),
                const SizedBox(width: 20 / 2),
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
          maxWidth: MediaQuery.of(ctx).size.width * 0.7,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF03738)
              .withOpacity(uid == currentUserId ? 1 : 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          msg,
          softWrap: true,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: uid == currentUserId ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
