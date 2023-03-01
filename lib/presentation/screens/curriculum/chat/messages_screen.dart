import 'package:esjourney/logic/cubits/chat/user/users_cubit.dart';
import 'package:esjourney/logic/cubits/chat/user/users_state.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/curriculum/chat/conversation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => MessagesScreenState();
}

class MessagesScreenState extends State<MessagesScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void loadUsers(String token) async {
    context.read<UsersDataCubit>().getAllUsers(token);

    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final getUsers = BlocProvider.of<UsersDataCubit>(context);
    final userState = context.read<UserCubit>().state;
    var currentUser;
    if (userState is UserLogInSuccess) {
      currentUser = userState.user;
      getUsers.getAllUsers(userState.user.token!);
    }
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
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () => loadUsers(currentUser.token!),
        child: Column(
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
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.gradeChatRoom,
                          arguments: {
                            'grade': currentUser.grade,
                            'token': currentUser.token,
                            'myUsername': currentUser.username,
                          },);
                      },
                      child: const Text("Grade Conversation")),
                  ElevatedButton(onPressed: () {}, child: const Text("Text")),
                ],
              ),
            ),
            BlocBuilder<UsersDataCubit, UsersDataState>(
              builder: (context, state) {
                if (state is UsersDataInitial) {
                  return const Center(child: Text("Initial"));
                } else if (state is UsersDataLoadInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UsersDataLoadingSuccess) {
                  final chatsData = state.users;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: chatsData.length,
                      itemBuilder: (context, index) => ConversationCard(
                        chat: chatsData[index],
                        press: () => Navigator.of(context).pushNamed(
                          AppRoutes.conversation,
                          arguments: {
                            'receiver': chatsData[index],
                            'myUsername': currentUser.username,
                            'token': currentUser.token,
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text("Error"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
