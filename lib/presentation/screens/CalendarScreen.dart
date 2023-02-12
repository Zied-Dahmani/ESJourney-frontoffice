import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:esjourney/data/models/orientation/event_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime selectedDay;
  late DateTime focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<Event> events = [
    Event(
        title: 'Event 1',
        date: DateTime.now(),
        description: 'This is event 1',
        isDone: 'true',
        //13:00
        startTime: "13:00",
        endTime: "14:00"),
    Event(
        title: 'Event 4',
        date: DateTime.now(),
        description: 'This is event 4',
        isDone: 'false',
        //13:00
        startTime: "15:00",
        endTime: "16:00"),
    Event(
      title: 'Event 2',
      date: DateTime.now().add(Duration(days: 1)),
      description: 'This is event 2',
      isDone: 'false',
      startTime: "All day",
    ),
    Event(
        title: 'Event 3',
        date: DateTime.now().add(Duration(days: 2)),
        description: 'This is event 3',
        isDone: 'false',
        startTime: "All day"),
  ];

  List<Event> _getEventsForDay(DateTime day) {
    return events.where((event) => isSameDay(event.date, day)).toList();
  }

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
  }

  void currentDay() {
    setState(() {
      selectedDay = DateTime.now();
      focusedDay = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Event> eventsForSelectedDay = _getEventsForDay(selectedDay);
    return BlocBuilder<UserCubit,UserState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Calendar'),
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
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;
                  });
                },
                daysOfWeekHeight: 30,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  this.focusedDay = focusedDay;
                },
                calendarStyle: CalendarStyle(
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
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: eventsForSelectedDay.length,
                  itemBuilder: (context, index) {
                    Event event = eventsForSelectedDay[index];
                    return ListTile(
                      title: Text(
                        event.title,
                        style: TextStyle(
                          color: Color(0xFFEB4A5A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        event.description,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      /*********trailing********/
                      trailing: event.isDone == 'true'
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          Text('Done', style: TextStyle(color: Colors.green))
                        ],
                      )
                          : event.startTime != null
                          ? FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer, color: Colors.grey),
                            Text(
                              event.startTime,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            event.endTime != null
                                ? Text(
                              event.endTime!,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                                : SizedBox(),
                          ],
                        ),
                      )
                          : SizedBox(),
                      /*********trailing********/
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: currentDay,
            child: Icon(Icons.today),
          ),
        );
      }
    );
  }
}
