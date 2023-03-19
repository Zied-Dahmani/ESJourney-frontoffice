import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'edit_profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            // Write the code to navigate back to the previous screen
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.editProfileScreen
                  // Write the code to navigate to the edit profile screen
                  );


              // Write the code to navigate to the settings screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomContainer(
                  width: width,
                  backgroundColor: theme.colorScheme.onPrimary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: width * 0.15,
                      ),
                      Center(
                        child: Text(
                          "userx",
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                      Container(
                        width: width,
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: // custom color hex code
                                  Color(0xFFE7E7E7),
                              offset: Offset(6.0, 8.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0, // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const ProfileContainer(
                                icon: Icons.monetization_on_outlined,
                                title: "Coins",
                                subtitle: "5000",
                              ),
                              SizedBox(
                                height: width * 0.13,
                                child: VerticalDivider(
                                  color: Colors.grey[100],
                                  thickness: 1,
                                ),
                              ),
                              const ProfileContainer(
                                icon: Icons.leaderboard_outlined,
                                title: "Rank",
                                subtitle: "1",
                              ),
                              SizedBox(
                                height: width * 0.13,
                                child: VerticalDivider(
                                  color: Colors.grey[100],
                                  thickness: 1,
                                ),
                              ),
                              const ProfileContainer(
                                icon: Icons.leaderboard_outlined,
                                title: "Grade",
                                subtitle: "1",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: width * 0.05,
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
                          child: const Text("Badges (2)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'VisbyRoundCF',
                              ))),
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/challenges/first_badge.svg',
                              height: width * 0.15,
                            ),
                            SvgPicture.asset(
                              'assets/icons/challenges/trophy.svg',
                              height: width * 0.15,
                            ),
                            SvgPicture.asset(
                              'assets/icons/challenges/second_badge.svg',
                              height: width * 0.15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Stack(
                      children: const [
                        CircleAvatar(
                          backgroundImage:
                          AssetImage('assets/images/challenges/avatar.png'),
                          radius: 50,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.grey,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'VisbyRoundCF',
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'VisbyRoundCF',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.width,
    required this.backgroundColor,
    this.child,
    this.margin = const EdgeInsets.only(left: 5.0, right: 5.0, top: 60.0),
  });

  final double width;
  final Color backgroundColor;
  final Widget? child;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(0.0),
        ),
      ),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
