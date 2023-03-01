import 'package:esjourney/data/repositories/chat/chat_service.dart';
import 'package:esjourney/presentation/screens/curriculum/chat/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatGradeRoomScreen extends StatefulWidget {
  const ChatGradeRoomScreen(
      {Key? key,
      required this.grade,
      required this.token,
      required this.myUsername})
      : super(key: key);
  final int grade;
  final String myUsername;
  final String token;

  @override
  State<ChatGradeRoomScreen> createState() => _ChatGradeRoomScreenState();
}

class _ChatGradeRoomScreenState extends State<ChatGradeRoomScreen>
    with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  late SocketService socketService;
  late ChatService chatService;
  final List<ChatMessage> _messages = [];

  _handleSubmit(String text) {
    if (text.isEmpty) return;

    _textController.clear();

    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      currentUsername: widget.myUsername,
      msg: text,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 400,
        ),
      ),
      username: widget.myUsername,
      grade: widget.grade,
    );

    //todo: this pops up the message twice
    //_messages.insert(0, newMessage);
    newMessage.animationController.forward();

    socketService.emit('group-message',
        {'from': widget.myUsername, 'grade': widget.grade, 'message': text});
  }

  void _listenMessage(dynamic payload) {
    ChatMessage message = ChatMessage(
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
      username: payload["from"],
      msg: payload["message"],
      currentUsername: widget.myUsername,
      grade: widget.grade,
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
    socketService.socket.on("group-message", _listenMessage);
    _chargeHistory(widget.token);
  }

  @override
  void dispose() {
    super.dispose();
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService.socket.off("group-message");
  }

  void _chargeHistory(String token) async {
    List<dynamic> messages = await chatService.getChatByGrade(token);

    final history = messages.map((m) => ChatMessage(
          currentUsername: widget.myUsername,
          animationController: AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 0),
          )..forward(),
          msg: m.message,
          username: m.from,
          grade: widget.grade,
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
                        onPressed: () {
                          if (_textController.text.isNotEmpty) {
                            _handleSubmit(_textController.text.trim());
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB4A5A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/app_logo.png"),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "first grade",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
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
  final String username;
  final String currentUsername;
  final int grade;
  final AnimationController animationController;

  const ChatMessage({
    Key? key,
    required this.msg,
    required this.username,
    required this.animationController,
    required this.currentUsername,
    required this.grade,
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
              messageBox(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget messageBox(BuildContext ctx) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (username != currentUsername) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                username,
                style: const TextStyle(
                  color: Color(0xFFA0A5BD),
                  fontSize: 12,
                ),
              ),
            ),
          ],
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(ctx).size.width * 0.7,
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
                color:
                    username == currentUsername ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
