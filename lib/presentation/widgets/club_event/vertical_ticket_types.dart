import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/club_event/club_event_ticket_screen.dart';
import 'package:esjourney/presentation/widgets/club_event/ticket_type.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter/material.dart';

class VerticalTicketTypes extends StatefulWidget {
  const VerticalTicketTypes({Key? key, this.clubEvent}) : super(key: key);

  final clubEvent;

  @override
  State<VerticalTicketTypes> createState() => _VerticalTicketTypesState();
}

class _VerticalTicketTypesState extends State<VerticalTicketTypes> with TickerProviderStateMixin {

  bool _selectedMode = false;
  late AnimationController _selectionAnimationController;
  late AnimationController _movementAnimationController;
  int? _selectedCardIndex;

  @override
  void initState() {
    super.initState();
    _selectionAnimationController = AnimationController(
        vsync: this,
        lowerBound: .15,
        upperBound: .5,
        duration: const Duration(milliseconds: 500));
    _movementAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 880));
  }

  @override
  void dispose() {
    _selectionAnimationController.dispose();
    _movementAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
        animation: _selectionAnimationController,
        builder: (context, snapshot) {
          final selectionValue = _selectionAnimationController.value;
          return GestureDetector(
            onTap: () {
              if (!_selectedMode) {
                _selectionAnimationController
                    .forward()
                    .then((value) => setState(() {
                          _selectedMode = true;
                        }));
              } else {
                _selectionAnimationController
                    .reverse()
                    .then((value) => setState(() {
                          _selectedMode = false;
                        }));
              }
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, .001)
                ..rotateX(selectionValue),
              child: AbsorbPointer(
                absorbing: !_selectedMode,
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth / 1.7,
                  color: theme.colorScheme.background,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: List.generate(
                        widget.clubEvent.ticketTypeImages.length,
                        (index) => TicketType(
                              height: constraints.maxHeight / 2,
                              percent: selectionValue,
                              depth: index,
                              verticalFactor: _getCurrentFactor(index),
                              animation: _movementAnimationController,
                              image: widget.clubEvent.ticketTypeImages[index],
                              onCardSelected: () {
                                _onCardSelected(index);
                              },
                            )).reversed.toList(),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  int _getCurrentFactor(int currentIndex) {
    if (_selectedCardIndex == null || currentIndex == _selectedCardIndex) {
      return 0;
    } else if (currentIndex > _selectedCardIndex!) {
      return -1;
    } else {
      return 1;
    }
  }

  Future<void> _onCardSelected(index) async {
    setState(() {
      _selectedCardIndex = index;
    });
    const duration = Duration(milliseconds: 750);
    await Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        pageBuilder: (context, animation, _) => FadeTransition(
            opacity: animation,
            child: ClubEventTicketScreen(clubEvent: widget.clubEvent, ticketTypeIndex: index))));
    _movementAnimationController.reverse(from: 1.0);
  }

}
