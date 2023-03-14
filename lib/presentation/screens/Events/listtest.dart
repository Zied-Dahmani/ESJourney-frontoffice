import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esjourney/logic/cubits/events/event_cubit.dart';
import 'package:esjourney/logic/cubits/events/event_state.dart';
import '../../../data/models/events/event_model.dart';
import '../../../utils/constants.dart';
import '../../router/routes.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> events = [];
  DateTime? _selectedDate;
  int _currentEventIndex = 0;
  bool isLoading = false;


  Future<void> _onRefresh() async {
    context.read<EventCubit>().getAllEvents();
    final eventState = context.read<EventCubit>().state;
    if (eventState is EventSuccess) {
      setState(() {
        events = eventState.events;
        _selectedDate = _selectedDate ?? DateTime.now();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: BlocConsumer<EventCubit, EventState>(
          listener: (context, state) {
            if (state is EventSuccess) {
              events = state.events;
            }
          },
          builder: (context, state) {
            if (state is EventSuccess) {
              events = state.events;
            }
            return Stack(
              children: [
                Image.asset(
                  events.isNotEmpty ? events[_currentEventIndex].eventImage : '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SafeArea(
                      child: Center(
                        child: ScaledList(
                          itemCount: events.length,
                          itemColor: (index) {
                            return kMixedColors[index % kMixedColors.length];
                          },
                          itemBuilder: (index, selectedIndex) {
                            final event = events[index];
                            return Container(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    event.title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: selectedIndex == index ? 25 : 20,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        DateFormat('dd/MM/yyyy').format(event.date),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: selectedIndex == index ? 12 : 8,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          event.location,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: selectedIndex == index ? 12 : 8,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }


  final List<Color> kMixedColors = [
    Color(0xff71A5D7),
    Color(0xff72CCD4),
    Color(0xffFBAB57),
    Color(0xffF8B993),
    Color(0xff962D17),
    Color(0xffc657fb),
    Color(0xfffb8457),
  ];
}
