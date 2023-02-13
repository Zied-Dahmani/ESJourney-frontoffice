import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:esjourney/data/models/orientation/event_model.dart';

import '../zoom_drawer_screen.dart';
import 'event_details_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<Event> events = [
    Event(
        id: '1',
        title: 'Student Management System C++',
        date: DateTime.now(),
        description:
            'The Student Management System is a program that aims to simplify the process of recording and managing student data in a school or educational institution. It is a menu-driven program that allows users to perform various tasks such as adding new students, updating existing records, viewing student information, and generating reports. The program is written in C++ and utilizes object-oriented programming concepts such as classes, objects, and inheritance.The Student Management System is a program that aims to simplify the process of recording and managing student data in a school or educational institution. It is a menu-driven program that allows users to perform various tasks such as adding new students, updating existing records, viewing student information, and generating reports. The program is written in C++ and utilizes object-oriented programming concepts such as classes, objects, and inheritance.',
        isDone: 'true',
        type: 'Orientation',
        startTime: "13:00",
        endTime: "14:00",
        eventImage: 'assets/images/C++event.png'),
    Event(
        id: '2',
        title: 'Event 4',
        date: DateTime.now(),
        description: 'This is event 4',
        isDone: 'false',
        type: 'Project',
        startTime: "All day"),
    Event(
      id: '3',
      title: 'Event 2',
      date: DateTime.now().add(const Duration(days: 1)),
      description: 'This is event 2',
      isDone: 'false',
      type: 'Orientation',
      startTime: "11:00",
      endTime: "12:00",
    ),
    Event(
        id: '4',
        title: 'Event 3',
        date: DateTime.now().add(const Duration(days: 2)),
        description: 'This is event 3',
        isDone: 'false',
        type: 'Project',
        startTime: "All day"),
  ];

  List<Event> _getEventsForDay(DateTime day) {
    return events.where((event) => isSameDay(event.date, day)).toList();
  }

  void currentDay() {
    setState(() {
      selectedDay = DateTime.now();
      focusedDay = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    var date = selectedDay;
    final eventsForSelectedDay = _getEventsForDay(selectedDay);
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TableCalendar(
              eventLoader: _getEventsForDay,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
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
                defaultDecoration: const BoxDecoration(shape: BoxShape.circle),
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
              child: ListView.builder(
                itemCount: eventsForSelectedDay.length,
                itemBuilder: (context, index) {
                  final event = eventsForSelectedDay[index];
                  final border = event.type == 'Orientation'
                      ? const Border(
                          left: BorderSide(color: Color(0xFFEB4A5A), width: 5))
                      : event.type == 'Project'
                          ? const Border(
                              left: BorderSide(color: Colors.black, width: 5))
                          : null;
                  final textStyle = event.type == 'Orientation'
                      ? const TextStyle(color: Color(0xFFEB4A5A))
                      : event.type == 'Project'
                          ? const TextStyle(color: Colors.black)
                          : null;

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetails(
                            eventId: event.id,
                            title: event.title,
                            startTime: event.startTime,
                            description: event.description,
                            endTime: event.endTime,
                            type: event.type!,
                            date: date,
                            isDone: event.isDone!,
                            eventImage: event.eventImage,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, top: 8),
                      decoration:
                          border != null ? BoxDecoration(border: border) : null,
                      child: ListTile(
                        title: textStyle != null
                            ? Text(event.title, style: textStyle)
                            : null,
                        subtitle: Text(event.description,
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis
                        ),
                        trailing: event.isDone == 'true'
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  Text('Done',
                                      style: TextStyle(color: Colors.green))
                                ],
                              )
                            : event.startTime != null
                                ? FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.timer,
                                            color: Colors.grey),
                                        Text(
                                          event.startTime,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        event.endTime != null
                                            ? Text(
                                                event.endTime!,
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: currentDay,
          child: const Icon(Icons.today),
        ),
      );
    });
  }
}
