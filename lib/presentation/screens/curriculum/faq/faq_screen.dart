import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({Key? key}) : super(key: key);
  final _replyController = TextEditingController();
  final _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('FAQ'),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            children: [
              Expanded(
                child: SearchBarAnimation(
                  textEditingController: TextEditingController(),
                  isOriginalAnimation: true,
                  enableKeyboardFocus: false,
                  enableBoxBorder: false,
                  trailingWidget: const Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.black,
                  ),
                  secondaryButtonWidget: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black,
                  ),
                  buttonWidget: const Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _askQuestion(context, _questionController);
                },
                child: const Text("ASK"),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text(
                    "Your question goes here ?",
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () {
                      _showReplies(context, _replyController);
                    },
                    child: const Text("View All"),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  _askQuestion(ctx, controller) {
    showModalBottomSheet(
        context: ctx,
        enableDrag: true,
        useSafeArea: true,
        isScrollControlled: true,
        isDismissible: true,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        builder: (context) {
          return Container(
            margin:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        maxLines: 1,
                        controller: controller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        expands: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Ask a question',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () {
                        //Navigator.of(context).pop();
                      },
                      child: const Text("Post"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showReplies(ctx, controller) {
    showModalBottomSheet(
      context: ctx,
      enableDrag: true,
      useSafeArea: true,
      isScrollControlled: false,
      isDismissible: true,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: CommentTreeWidget<Comment, Comment>(
                  Comment(
                      avatar: 'null',
                      userName: 'user',
                      content: 'Your question goes here ?'),
                  [
                    Comment(
                        avatar: 'null',
                        userName: 'user1',
                        content: 'first comment'),
                    Comment(
                        avatar: 'null',
                        userName: 'user2',
                        content: 'second comment'),
                    Comment(
                        avatar: 'null',
                        userName: 'user3',
                        content: 'third comment'),
                    Comment(
                        avatar: 'null',
                        userName: 'user4',
                        content: 'fourth comment'),
                  ],
                  treeThemeData: TreeThemeData(
                      lineColor: Colors.green[500]!, lineWidth: 3),
                  avatarRoot: (context, data) => const PreferredSize(
                    preferredSize: Size.fromRadius(18),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('assets/images/app_logo.png'),
                    ),
                  ),
                  avatarChild: (context, data) => const PreferredSize(
                    preferredSize: Size.fromRadius(12),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('assets/images/app_logo.png'),
                    ),
                  ),
                  contentChild: (context, data) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${data.userName}'),
                          const SizedBox(
                            height: 4,
                          ),
                          Text('${data.content}'),
                        ],
                      ),
                    );
                  },
                  contentRoot: (context, data) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.userName}',
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${data.content}',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10,left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        controller: controller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        expands: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Add a reply',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //Navigator.of(context).pop();
                      },
                      child: const Text("Post"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
