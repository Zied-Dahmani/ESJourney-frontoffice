import 'package:esjourney/data/models/events/event_model.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/constants.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool isLoading = false;
  BuildContext? dialogContext;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  Future<void> _onRefresh() async {
    final userState = context.read<UserCubit>().state;
    if (userState is UserLogInSuccess) {
      final token = userState.user.token;
      context.read<UserCubit>().refreshUserData(token!);
    }
  }

  void _currentDay() {
    setState(() {
      selectedDay = DateTime.now();
      focusedDay = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.bars,
            color: Colors.black,
          ),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.calendarDay,
              color: Color(0xFFEB4A5A),
            ),
            onPressed: () {
              _currentDay();
            },
          ),
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLogInSuccess) {
            final events = state.user.events;
            final eventsForSelectedDay = _getEventsForDay(selectedDay, events!);
            return Column(
              children: [
                TableCalendar(
                  eventLoader: (day) => _getEventsForDay(day, events),
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                  onDaySelected: (selected, focused) {
                    setState(() {
                      selectedDay = selected;
                      focusedDay = focused;
                    });
                  },
                  daysOfWeekHeight: 30,
                  onFormatChanged: (format) =>
                      setState(() => _calendarFormat = format),
                  onPageChanged: (focused) => focusedDay = focused,
                  calendarStyle: CalendarStyle(
                    markersAlignment: Alignment.bottomRight,
                    isTodayHighlighted: true,
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFEB4A5A),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(color: Colors.white),
                    todayDecoration: BoxDecoration(
                      color: Colors.red[100],
                      shape: BoxShape.circle,
                    ),
                    defaultDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) => events.isNotEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.05,
                            height: MediaQuery.of(context).size.width * 0.05,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              '${events.length}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          )
                        : null,
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: isLoading
                        ? const Center()
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: eventsForSelectedDay.length,
                            itemBuilder: (context, index) {
                              final event = eventsForSelectedDay[index];
                              final border = event.type == 'Orientation'
                                  ? const Border(
                                      left: BorderSide(
                                          color: Color(0xFFEB4A5A), width: 5))
                                  : event.type == 'Project'
                                      ? const Border(
                                          left: BorderSide(
                                              color: Colors.black, width: 5))
                                      : null;
                              final textStyle = event.type == 'Orientation'
                                  ? const TextStyle(color: Color(0xFFEB4A5A))
                                  : event.type == 'Project'
                                      ? const TextStyle(color: Colors.black)
                                      : null;

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.eventDetails,
                                      arguments: event);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 2, top: 8, right: 2),
                                  decoration: border != null
                                      ? BoxDecoration(border: border)
                                      : null,
                                  child: Material(
                                    elevation: 4,
                                    child: ListTile(
                                      title: textStyle != null
                                          ? Text(event.title, style: textStyle)
                                          : null,
                                      subtitle: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on,
                                                  color: Colors.black54,
                                                  size: 18),
                                              const SizedBox(width: 5),
                                              event.location != null
                                                  ? Text(event.location,
                                                      style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 12))
                                                  : const Text('No location',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 12)),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(Icons.access_time,
                                                  color: Colors.black54,
                                                  size: 18),
                                              const SizedBox(width: 5),
                                              event.endTime != null
                                                  ? Text(
                                                      '${event.startTime} - ${event.endTime}',
                                                      style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15))
                                                  : Text(event.startTime,
                                                      style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                        child: event.isDone == false
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: const [
                                                  Icon(
                                                    Icons.timer,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Soon',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: const [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Done',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day, List<Event> events) {
    return events.where((event) => isSameDay(event.date, day)).toList();
  }
}
