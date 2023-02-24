import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/curriculum/chat/conversation_card.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => MessagesScreenState();
}

class MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB4A5A),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Messages",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFEB4A5A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                ElevatedButton(onPressed: (){}, child: const Text("Text")),
                ElevatedButton(onPressed: (){}, child: const Text("Text")),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ConversationCard(
                chat: chatsData[index],
                press: () =>
                    Navigator.of(context).pushNamed(AppRoutes.conversation),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

