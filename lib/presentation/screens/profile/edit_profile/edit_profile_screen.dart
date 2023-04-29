import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubits/user/user_cubit.dart';
import '../../../../logic/cubits/user/user_state.dart';
import '../../../../utils/screen_size.dart';
import '../../../router/routes.dart';
import '../../../widgets/challenges/user_info.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

String username = "";
bool switched = false;

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Builder(
          builder: (context) {
            final userState = context.watch<UserCubit>().state;
            final user = userState is UserLogInSuccess ? userState.user : null;
            if (userState is UserLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (userState is UserLogInSuccess) {
              username = userState.user.username;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          height: width * 0.3,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/challenges/avatar.png'),
                            radius: 50,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              height: width * 0.1,
                              width: width * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                shape: BoxShape.circle,
                                color: theme.colorScheme.outline,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.edit_outlined,
                                    color: Colors.white),
                                iconSize: width * 0.048,
                                onPressed: () {
                                  // Do something with the picked image file
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Account information",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'VisbyRoundCF',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 5, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        UserInfo(
                          infoTitle: "Username",
                          infoValue: username,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.updateUsername
                                // Write the code to navigate to the edit profile screen
                                );
                          },
                        ),
                        UserInfo(
                            infoTitle: "Email",
                            infoValue: "",
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  AppRoutes.updateUsername
                                  // Write the code to navigate to the edit profile screen
                                  );
                            }),
                        UserInfo(
                            infoTitle: "Password",
                            infoValue: "",
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  AppRoutes.updatePasswordScreen
                                  // Write the code to navigate to the edit profile screen
                                  );
                            })
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Content & Display",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'VisbyRoundCF',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 5, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 0),
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Push notifications",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'VisbyRoundCF',
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  switched = !switched;
                                });
                              },
                              child: Transform.scale(
                                scale: 0.7,
                                child: Theme(
                                  data: ThemeData(
                                    primarySwatch: Colors.blue,
                                    unselectedWidgetColor: Colors.deepPurple,
                                  ),
                                  child: Switch(
                                    value: switched,
                                    activeColor: theme.colorScheme.primary,
                                    inactiveTrackColor: Colors.grey[300],
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        switched = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              );
            } else if (userState is UserIsFailure) {
              return Center(
                child: Text(userState.error.toString()),
              );
            }
            return Container();
          },
        ));
  }
}
