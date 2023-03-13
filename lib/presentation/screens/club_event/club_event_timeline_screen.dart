import 'package:esjourney/presentation/widgets/club_event/animated_timeline_button.dart';
import 'package:esjourney/presentation/widgets/club_event/calendar_and_line.dart';
import 'package:esjourney/presentation/widgets/club_event/timeline_dot_and_card.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class ClubEventTimelineScreen extends StatefulWidget {
  const ClubEventTimelineScreen({Key? key, this.clubEvent}) : super(key: key);

  final clubEvent;

  @override
  State<ClubEventTimelineScreen> createState() =>
      _ClubEventTimelineScreenState();
}

class _ClubEventTimelineScreenState extends State<ClubEventTimelineScreen> {
  bool _animated = false, _displayCard = false, _animatedButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.ktimeline)),
        body: LayoutBuilder(builder: (context, constraints) {
          final centerDot =
              constraints.maxWidth / 2 - AppSizes.ktimelineDotSize / 2;
          return Stack(
            children: [
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  left: constraints.maxWidth / 2 - AppSizes.ktimeLineIcon / 2,
                  top: _animated
                      ? AppSizes.khugeSpace
                      : constraints.maxHeight - AppSizes.khugeSpace - 22,
                  bottom: AppSizes.kbigSpace,
                  child: const CalendarAndLine()),
              for (int i = 1; i <= widget.clubEvent.timeline.length; i++)
                AnimatedPositioned(
                    duration: Duration(milliseconds: 600 + i * 200),
                    left: i % 2 == 0 ? null : centerDot,
                    right: i % 2 == 0 ? centerDot : null,
                    top: _animated
                        ? AppSizes.khugeSpace + 80 * i
                        : constraints.maxHeight - AppSizes.khugeSpace - 10,
                    child: TimelineDotAndCard(
                        delay: Duration(milliseconds: i * 200),
                        isLeft: i % 2 == 0,
                        displayCard: _displayCard,
                        text: widget.clubEvent.timeline[i - 1])),
              if (_animatedButton)
                AnimatedTimelineButton(clubEvent: widget.clubEvent)
            ],
          );
        }));
  }

  Future<void> initAnimation() async {
    setState(() {
      _animated = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _displayCard = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _animatedButton = true;
    });
  }
}
