import 'dart:async';

import 'package:esjourney/presentation/screens/curriculum/games/slide/consts/Colors/colors.dart';
import 'package:esjourney/presentation/screens/curriculum/games/slide/consts/Textstyles/text_styles.dart';
import 'package:esjourney/presentation/screens/curriculum/games/slide/widgets/output/responsive_widget.dart';
import 'package:flutter/material.dart';

class StopwatchTimer extends StatefulWidget {
  final Stopwatch stopwatch;
  const StopwatchTimer({
    Key? key,
    required this.stopwatch,
  }) : super(key: key);

  @override
  _TimerTimeState createState() => _TimerTimeState();
}

class _TimerTimeState extends State<StopwatchTimer> {
  void callback(Timer timer) {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 30), callback);
  }

  @override
  Widget build(BuildContext context) {
    int minutes = widget.stopwatch.elapsed.inMinutes % 60;
    int seconds = widget.stopwatch.elapsed.inSeconds % 60;
    int hours = widget.stopwatch.elapsed.inHours % 60;

    return ResponsiveWidget(
        small: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}",
              style: SlideTextStyle.heading18.copyWith(
                  color: SlideColors.primary2,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.timer_rounded)
          ],
        ),
        medium: Text(
          "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}",
          style: SlideTextStyle.heading18.copyWith(
              color: SlideColors.grey3,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        large: Text(
          "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}",
          style: SlideTextStyle.heading18.copyWith(
              color: SlideColors.grey3,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ));
  }
}
