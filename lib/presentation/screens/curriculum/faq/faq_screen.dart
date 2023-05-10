import 'package:comment_tree/comment_tree.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQScreen extends StatefulWidget {
  FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final _replyController = TextEditingController();
  final _questionController = TextEditingController();

  //get current user from user cubit
  UserState? get _user => context.read<UserCubit>().state;
  var user;

  List<Question> _questions = [];

  _submitQuestion() {
    if (_user is UserLogInSuccess) {
      user = (_user as UserLogInSuccess).user;
    }
    if (_questionController.text.isNotEmpty) {
      setState(() {
        _questions.add(Question(
          avatar: user.twoDAvatar,
          userName: user.username,
          content: _questionController.text,
          replies: [],
        ));
      });
      _questionController.clear();
    }
  }

  _submitReply(Question question) {
    if (_replyController.text.isNotEmpty) {
      setState(() {
        question.replies?.add(Reply(
          avatar: user.twoDAvatar,
          userName: user.username,
          content: _replyController.text,
        ));
      });
      _replyController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      _askQuestion(context, _questionController);
                    },
                    child: const Text("ASK"),
                  ),
                ],
              ),
            ),
            for (var question in _questions) ...[
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
                        child: Text(
                          question.content,
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
                            _showReplies(context, _replyController, question);
                          },
                          child: const Text("View All"),
                        )),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  _askQuestion(ctx, controller) {
    showModalBottomSheet(
        context: ctx,
        enableDrag: true,
        //useSafeArea: true,
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
                        style: const TextStyle(
                          color: Colors.black,
                        ),
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
                        _submitQuestion();
                        Navigator.of(context).pop();
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

  _showReplies(ctx, controller, Question question) {
    showModalBottomSheet(
      context: ctx,
      enableDrag: true,
      //useSafeArea: true,
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
                      avatar: question.avatar,
                      userName: question.userName,
                      content: question.content),
                  [
                    for (var reply in question.replies!) ...[
                      Comment(
                          avatar: reply.avatar,
                          userName: reply.userName,
                          content: reply.content),
                    ],
                  ],
                  treeThemeData:
                      TreeThemeData(lineColor: Colors.red[200]!, lineWidth: 3),
                  avatarRoot: (context, data) => PreferredSize(
                    preferredSize: const Size.fromRadius(18),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(question.avatar),
                    ),
                  ),
                  avatarChild: (context, data) => PreferredSize(
                    preferredSize: const Size.fromRadius(12),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(question.avatar),
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
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        controller: controller,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
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
                        _submitReply(question);
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

class Question {
  final String avatar;
  final String userName;
  final String content;
  final List<Reply>? replies;

  Question(
      {required this.avatar,
      required this.userName,
      required this.content,
      this.replies});
}

class Reply {
  final String avatar;
  final String userName;
  final String content;

  Reply({required this.avatar, required this.userName, required this.content});
}
