import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Option extends StatefulWidget {
  const Option({
    Key? key,
    required this.text,
    required this.isOptionSelected,
    required this.isOptionCorrect,
    required this.isQuizAnswered,
  }) : super(key: key);

  final String text;
  final bool isOptionSelected;
  final bool isOptionCorrect;

  final bool isQuizAnswered;

  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: widget.isQuizAnswered
                  ? (widget.isOptionSelected
                      ? (widget.isOptionCorrect
                          ? theme.colorScheme.outline
                          : theme.colorScheme.primary)
                      : theme.colorScheme.tertiary)
                  : (widget.isOptionSelected
                      ? theme.colorScheme.outline
                      : theme.colorScheme.tertiary),
              width: 3.0),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.text.toLowerCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: widget.isQuizAnswered
                      ? (widget.isOptionSelected
                      ? (widget.isOptionCorrect
                      ? theme.colorScheme.outline
                      : theme.colorScheme.primary)
                      : theme.colorScheme.tertiary)
                      : (widget.isOptionSelected
                      ? theme.colorScheme.outline
                      : theme.colorScheme.onBackground),
                  fontFamily: 'VisbyRoundCF',
                ),
              ),
            ),
SizedBox(width:width*0.03),
            Container(
              height: width * 0.06,
              width: width * 0.06,
              decoration: BoxDecoration(
                border: Border.all(
                    color:         widget.isQuizAnswered
                        ? (widget.isOptionSelected
                        ? (widget.isOptionCorrect
                        ? theme.colorScheme.outline
                        : theme.colorScheme.primary)
                        : theme.colorScheme.tertiary)
                        : (widget.isOptionSelected ? theme.colorScheme.outline : theme.colorScheme.tertiary),
                    width: 3.0),
                // fill the circle with a color
                color:         widget.isQuizAnswered
                    ? (widget.isOptionSelected
                    ? (widget.isOptionCorrect
                    ? theme.colorScheme.outline
                    : theme.colorScheme.primary)
                    : theme.colorScheme.tertiary)
                    : (widget.isOptionSelected ? theme.colorScheme.outline : Colors.transparent),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: widget.isOptionSelected ? 1.0 : 0.0,
                  child: SvgPicture.asset(
                    widget.isQuizAnswered
                        ? (widget.isOptionSelected
                            ? (widget.isOptionCorrect
                                ? 'assets/icons/challenges/check_mark.svg'
                                : 'assets/icons/challenges/close_mark.svg')
                            : 'assets/icons/challenges/check_mark.svg')
                        : 'assets/icons/challenges/check_mark.svg',
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });

  }
}
