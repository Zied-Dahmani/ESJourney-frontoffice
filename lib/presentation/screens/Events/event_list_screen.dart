import 'package:esjourney/logic/cubits/events/event_cubit.dart';
import 'package:esjourney/logic/cubits/events/event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/models/events/event_model.dart';
import '../../../logic/cubits/user/user_cubit.dart';
import '../../../logic/cubits/user/user_state.dart';
import '../../../utils/constants.dart';
import '../../router/routes.dart';
import '../../widgets/events/event_card.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> events = [];
  DateTime? _selectedDate;
  bool isLoading = false;
  List<Event> allEvents = [];
  List<Event> displayedEvents = [];

  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.65)
      ..addListener(_pagePercentListener);
    _onRefresh();
    allEvents = events;
    displayedEvents = events;
  }
  void filterEvents(String filterType) {
    if (filterType == 'All') {
      displayedEvents = allEvents;
    } else {
      displayedEvents = allEvents
          .where((event) => event.type == filterType)
          .toList();
    }
    setState(() {});
  }
  _pagePercentListener() {
    setState(() {
      _currentIndex = _pageController.page!.round();
    });
  }

  Future<void> _onRefresh() async {
    final userState = context
        .read<UserCubit>()
        .state;
    if (userState is! UserLogInSuccess) return;
    final token = userState.user.token;
    await context.read<UserCubit>().refreshUserData(token!);
    context.read<EventCubit>().getAllEvents();
    final eventState = context
        .read<EventCubit>()
        .state;
    if (eventState is EventSuccess) {
      setState(() {
        events = eventState.events;
        _selectedDate ??= DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocConsumer<EventCubit, EventState>(
            listener: (context, state) {
              if (state is EventSuccess) {
                events = state.events;
              }
            },
            builder: (context, state) {
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: isLoading
                      ? const Center()
                      : NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowGlow();
                      return true;
                    },
                    child: Center(
                      child: FractionallySizedBox(
                        heightFactor: 0.75, // Adjust this value
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: events.length,
                          onPageChanged: (page) {
                            _pageController.animateToPage(
                              page,
                              duration: const Duration(milliseconds: 500),
                              curve: const Interval(0.25, 1, curve: Curves.decelerate),
                            );
                          },
                          itemBuilder: (_, index) {
                            final event = events[index];
                            final progress = (_currentIndex - index).abs();
                            final scale = (1 - (progress * 0.3).clamp(0, 1)).toDouble();

                            return Transform.scale(
                              scale: scale,
                              child: AspectRatio(
                                aspectRatio: 1, // makes the card a square
                                child: EventCard(event: event),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _selectDate(context),
        child: const Icon(
          Icons.calendar_today,
          color: Colors.white,
        ),
      ),
    );
  }




  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: kFirstDay,
      lastDate: kLastDay,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}