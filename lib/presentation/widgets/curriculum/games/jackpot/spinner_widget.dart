import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';

class SpinnerWidgetBox extends StatefulWidget {
  final spinnerImage;
  final isSpin;
  final controller;

  const SpinnerWidgetBox(
      {super.key,
      required this.spinnerImage,
      required this.isSpin,
      required this.controller});

  @override
  State<SpinnerWidgetBox> createState() => SpinnerWidgetBoxState();
}

class SpinnerWidgetBoxState extends State<SpinnerWidgetBox>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.435,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/curriculum/games/jackpot/Graphics/gfx-reel.png',
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, !widget.isSpin ? -0.15 : 0),
              end: const Offset(0, 0),
            ).animate(widget.controller),
            child: Image.asset('assets/images/curriculum/games/jackpot/Graphics/${widget.spinnerImage}'),
          )
        ],
      ),
    );
  }
}
