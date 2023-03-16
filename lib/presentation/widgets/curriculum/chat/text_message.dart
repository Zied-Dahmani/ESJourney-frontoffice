import 'package:esjourney/presentation/widgets/curriculum/chat/message_status_dot.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20 * 0.75,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF03738).withOpacity(message!.isSender ? 1 : 0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          message!.text,
          softWrap: true,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: message!.isSender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}