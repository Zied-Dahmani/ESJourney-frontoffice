import 'package:esjourney/presentation/widgets/curriculum/chat/audio_message.dart';
import 'package:esjourney/presentation/widgets/curriculum/chat/chat_input_field.dart';
import 'package:esjourney/presentation/widgets/curriculum/chat/message_status_dot.dart';
import 'package:esjourney/presentation/widgets/curriculum/chat/text_message.dart';
import 'package:esjourney/presentation/widgets/curriculum/chat/video_message.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "First User",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  "Active 3m ago",
                  style: TextStyle(fontSize: 12, color: Colors.white),
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
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: demoChatMessages.length,
                itemBuilder: (context, index) =>
                    Message(message: demoChatMessages[index]),
              ),
            ),
          ),
          const ChatInputField(),
        ],
      ),
    );
  }
}





class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.audio:
          return AudioMessage(message: message);
        case ChatMessageType.video:
          return const VideoMessage();
        default:
          return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/app_logo.png"),
            ),
            const SizedBox(width: 20 / 2),
          ],
          messageContaint(message),
          if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

