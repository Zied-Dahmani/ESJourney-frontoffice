import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    print("width: $width");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
            SvgPicture.asset(
              'assets/icons/challenges/leaderboard.svg',
              height: width * 1.035,
            ),
              Column(
                children: [
                  SizedBox(
                    height: width * 0.1,
                  ),
                  Center(
                    child: Text(
                      AppStrings.kleaderboard,
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'VisbyRoundCF',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: width * 0.05,
                  ),
                  const LeaderboardHistory(
                      buttonLabels: ["All time", "This week", "Month"]),
                ],
              ),
            ],
          ),
          TopThreeUsers(),
        ],
      ),
    );
  }
}

class TopThreeUsers extends StatelessWidget {
  const TopThreeUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.ac_unit),
        Container(
          width: 100, height: 100, // rounded shape with border
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Color(0xff3ED4A1),
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/challenges/cvpic.jpg'),
            ),
          ),
        )
        ,
        Container(
          


        )
      ],
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height - 120, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RandomCircles extends StatelessWidget {
  final double width;
  final double height;
  final double left;
  final double top;

  const RandomCircles({
    Key? key,
    required this.width,
    required this.height,
    required this.left,
    required this.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Transform.translate(
        offset: const Offset(0, 0),
        child: Opacity(
          opacity: 0.1,
          child: SizedBox(
            width: width,
            height: height,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LeaderboardHistory extends StatefulWidget {
  final List<String> buttonLabels;
  final void Function(int buttonIndex)? onClick;

  const LeaderboardHistory({Key? key, required this.buttonLabels, this.onClick})
      : super(key: key);

  @override
  _LeaderboardHistoryState createState() => _LeaderboardHistoryState();
}

class _LeaderboardHistoryState extends State<LeaderboardHistory> {
  int selectedButtonIndex = 0;

  void _onButtonPressed(int buttonIndex) {
    setState(() {
      selectedButtonIndex = buttonIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: theme.colorScheme.onPrimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.buttonLabels.length, (index) {
              return _buildButton(index, widget.buttonLabels[index]);
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(int buttonIndex, String buttonLabel) {
    final isSelected = buttonIndex == selectedButtonIndex;

    return InkWell(
      onTap: () => _onButtonPressed(buttonIndex),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 11.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3C4150) : null,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          buttonLabel,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontFamily: 'VisbyRoundCF',
            fontSize: isSelected ? 16.0 : 13.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
