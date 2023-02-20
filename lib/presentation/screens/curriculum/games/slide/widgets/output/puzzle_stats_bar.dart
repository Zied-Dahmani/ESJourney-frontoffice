import 'package:esjourney/presentation/screens/curriculum/games/slide/consts/Textstyles/text_styles.dart';
import 'package:esjourney/presentation/screens/curriculum/games/slide/tools/board_controller.dart';
import 'package:esjourney/presentation/screens/curriculum/games/slide/widgets/output/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzleStatsBar extends StatefulWidget {
  final double fontSize;
  const PuzzleStatsBar({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  @override
  _PuzzleStatsBarState createState() => _PuzzleStatsBarState();
}

class _PuzzleStatsBarState extends State<PuzzleStatsBar> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      small: SizedBox(
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.width * 0.45,
        child: Consumer<BoardController>(builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    text: value.moves.toString().padLeft(2, '0'),
                    style: SlideTextStyle.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Moves',
                        style: SlideTextStyle.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                    height: 25,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: value.tilesLeft.toString().padLeft(2, '0'),
                    style: SlideTextStyle.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Tiles',
                        style: SlideTextStyle.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
            ],
          );
        }),
      ),
      medium: Container(
        constraints: const BoxConstraints(
            maxHeight: 30, minHeight: 25, maxWidth: 280, minWidth: 180),
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.1,
        child: Consumer<BoardController>(builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    text: value.moves.toString().padLeft(2, '0'),
                    style: SlideTextStyle.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Moves',
                        style: SlideTextStyle.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: value.tilesLeft.toString().padLeft(2, '0'),
                    style: SlideTextStyle.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Tiles',
                        style: SlideTextStyle.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
            ],
          );
        }),
      ),
      large: Container(
        constraints: const BoxConstraints(
            maxHeight: 30, minHeight: 25, maxWidth: 280, minWidth: 180),
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.1,
        child: Consumer<BoardController>(builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    text: value.moves.toString().padLeft(2, '0'),
                    style: SlideTextStyle.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Moves',
                        style: SlideTextStyle.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: value.tilesLeft.toString().padLeft(2, '0'),
                    style: SlideTextStyle.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Tiles',
                        style: SlideTextStyle.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
            ],
          );
        }),
      ),
    );
  }
}
