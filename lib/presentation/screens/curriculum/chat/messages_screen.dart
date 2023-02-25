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
  const MessagesScreen({Key? key, required this.token}) : super(key: key);
  final String token;

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
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLogInSuccess) {
          final user = state.user;
          final token = user.token!;
          getUsers.getAllUsers(token);
          return SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: () => loadUsers(widget.token),
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
                          onPressed: () {}, child: const Text("Text")),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Text")),
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
                                'myId': user.id,
                                'token': token,
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
          );
        } else {
          return const Center(child: Text("Error"));
        }
      }),
    );
  }
}
