import 'dart:ui';
import 'package:countup/countup.dart';
import 'package:esjourney/logic/cubits/club_event/club_event_cubit.dart';
import 'package:esjourney/presentation/screens/club_event/payment_screen.dart';
import 'package:esjourney/presentation/widgets/club_event/ticket_section.dart';
import 'package:esjourney/presentation/widgets/club_event/ticket_type_card.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClubEventTicketScreen extends StatefulWidget {
  const ClubEventTicketScreen({Key? key, this.clubEvent, this.ticketTypeIndex})
      : super(key: key);

  final clubEvent, ticketTypeIndex;

  @override
  State<ClubEventTicketScreen> createState() => _ClubEventTicketScreenState();
}

class _ClubEventTicketScreenState extends State<ClubEventTicketScreen> {
  final PageController _pageController =
      PageController(viewportFraction: .8, initialPage: 1);

  double _page = 1;
  double _pageClamp = 1;
  late double _opacity;
  double verPos = 0.0;
  late Size size;
  double remainingTickets = 0.0;

  void _pageListener() {
    setState(() {
      _page = _pageController.page!;
      _pageClamp = _page.clamp(0, 1);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
    remainingTickets = BlocProvider.of<ClubEventCubit>(context).remainingTickets(widget.clubEvent, widget.clubEvent.ticketTypeNames[widget.ticketTypeIndex]);
    _opacity = remainingTickets == 0 ? 0 : 1;
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _opacity = 0;
        });
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Ticket section
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              top: MediaQuery.of(context).padding.top - verPos,
              left: (size.width * .1 - verPos).clamp(0, double.infinity),
              right: (size.width * .1 - verPos).clamp(0, double.infinity),
              bottom: size.height * .75 - verPos,
              child: Opacity(
                opacity: _opacity,
                child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    curve: Curves.ease,
                    duration: const Duration(seconds: 4),
                    builder:
                        (BuildContext context, double opacity, Widget? child) {
                      return Opacity(
                        opacity: opacity,
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          duration: const Duration(milliseconds: 150),
                          child: _pageClamp < .9
                              ? const SizedBox.shrink()
                              : AbsorbPointer(
                                  absorbing: remainingTickets == 0,
                                  child: GestureDetector(
                                    onVerticalDragUpdate: onVerticalDrag,
                                    onVerticalDragEnd: onVerticalDragEnds,
                                    child: TicketSection(
                                        verticalPos: verPos,
                                        clubEvent: widget.clubEvent,
                                        ticketTypeIndex:
                                            widget.ticketTypeIndex),
                                  ),
                                ),
                        ),
                      );
                    }),
              ),
            ),

            // Ticket type name & count
            Positioned(
                top: size.height * .85 + verPos,
                left: size.width * .1,
                right: size.width * .1,
                child: _pageClamp < .9
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          Text(
                              widget.clubEvent
                                  .ticketTypeNames[widget.ticketTypeIndex],
                              style: theme.textTheme.headlineLarge),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Countup(
                                begin: 1999,
                                end: remainingTickets,
                                duration: const Duration(seconds: 3),
                                separator: ',',
                                style: theme.textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.outline),
                              ),
                              Text(AppStrings.kremainingTickets,
                                  style: theme.textTheme.bodySmall),
                            ],
                          )
                        ],
                      )),

            // Card background
            Positioned(
              top: _pageClamp * size.height * .275 + verPos,
              bottom: _pageClamp * size.height * .225 - verPos,
              left: _pageClamp * size.width * .1,
              right: _pageClamp * size.width * .2,
              child: Opacity(
                opacity: _opacity,
                child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    curve: Curves.ease,
                    duration: const Duration(seconds: 4),
                    builder:
                        (BuildContext context, double opacity, Widget? child) {
                      return Opacity(
                        opacity: opacity,
                        /*child: Transform.translate(
                          offset: Offset(
                              _page < 1 ? 0 : (-1 * _page * ScreenSize.width(context) + ScreenSize.width(context)), 0),*/
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  _pageClamp * AppSizes.kradius),
                              color: theme.colorScheme.primary,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withAlpha(150),
                                    blurRadius: 20.0),
                              ]),
                        ),
                        //),
                      );
                    }),
              ),
            ),

            // Payment screen
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _page < 0.1 ? PaymentScreen(page: _page) : null,
            ),

            // Cards list
            Positioned(
                top: _page == 0 ? 0 : (size.height * .25) + verPos,
                bottom: _page == 0 ? 0 : size.height * .2 - verPos,
                left: 20,
                right: 0,
                child: PageView(
                    physics: remainingTickets == 0
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    controller: _pageController,
                    children: [
                      const SizedBox.shrink(),
                      Transform.translate(
                        offset:
                            Offset(_page < 1 ? (1 - _pageClamp) * 50 : 0, 0),
                        child: Hero(
                            tag: widget.clubEvent
                                .ticketTypeImages[widget.ticketTypeIndex],
                            child: TicketTypeCard(
                                image: widget.clubEvent
                                    .ticketTypeImages[widget.ticketTypeIndex],
                                elevation: 0.0)),
                      )
                    ])),
          ],
        ),
      ),
    );
  }

  void onVerticalDrag(DragUpdateDetails details) {
    setState(() {
      verPos += details.primaryDelta!;
      verPos = verPos.clamp(0, double.infinity);
    });
  }

  void onVerticalDragEnds(DragEndDetails details) {
    setState(() {
      if (details.primaryVelocity! > 500 || verPos > size.height / 2) {
        verPos = size.height - 40;
      }
      if (details.primaryVelocity! < -500 || verPos < size.height / 2) {
        verPos = 0;
      }
    });
  }
}
