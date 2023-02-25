import 'package:esjourney/data/models/events/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../logic/cubits/events/event_cubit.dart';
import '../../../logic/cubits/events/event_state.dart';
import '../../../logic/cubits/user/user_cubit.dart';
import '../../../logic/cubits/user/user_state.dart';

class EventDetails extends StatefulWidget {
  final String eventId;

  const EventDetails({
    Key? key,
     required this.eventId,
  }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  get textTheme => Theme.of(context).textTheme;
  late Event event;
  String _buttonText = 'Register';
  MaterialColor _buttonColor = Colors.green;

  void updateButtonText(String text, MaterialColor color) {
    setState(() {
      _buttonText = text;
      _buttonColor = color;
    });
  }

  /*void _fetchEvent() async {
    final eventState = context.read<EventCubit>().state;
    final userEvents = (eventState as EventSuccess).events;
      final events = eventState.events;
      final userState = context.read<UserCubit>().state;
      if (userState is UserLogInSuccess) {
        final isRegistered = userEvents
            .where((element) => element.id == widget.eventId)
            .isNotEmpty;
        print('isRegistered $isRegistered');
        print('userEvents $userEvents');
        print(userState.user.events);
        print('widget.eventId ${widget.eventId}');
        print('events hereeee $events');
        setState(() {
          event = events.firstWhere((element) => element.id == widget.eventId);
          if (isRegistered) {
            updateButtonText('Unregister', Colors.red);
          } else {
            updateButtonText('Register', Colors.green);
          }
        });

    }
  }*/
  void _fetchEvent() {
    final eventState = context.read<EventCubit>().state;
    if (eventState is! EventSuccess) return;

    final events = eventState.events;
    final userState = context.read<UserCubit>().state;
    if (userState is! UserLogInSuccess) return;

    final isRegistered = userState.user.events
        ?.map((e) => e.id)
        .contains(widget.eventId) ??
        false;
    print('isRegistered $isRegistered');
    print('widget.eventId ${widget.eventId}');
    print('aaaaaaaaaaa');
    print(userState.user.events);
    print('aaaaaaaaaaaa');
    print('events hereeee $events');
    setState(() {
      event = events.firstWhere((element) => element.id == widget.eventId);
      updateButtonText(isRegistered ? 'Unregister' : 'Register',
          isRegistered ? Colors.red : Colors.green);
    });
  }


  @override
  void initState() {
    super.initState();
    _fetchEvent();
  }

  Future<void> _registerOrUnregister() async {
    final userState = context.read<UserCubit>().state;
    if (userState is UserLogInSuccess) {
      final userEvents = userState.user.events?.map((e) => e.id).toList();
      final eventState = context.read<EventCubit>().state;
      if (eventState is EventSuccess)  {
        final event = eventState.events.firstWhere(
              (element) => element.id == widget.eventId,
        );
        if (userEvents!.contains(event.id)) {
          // user is already registered, so unregister them
          await context.read<EventCubit>().registerEvent(
            userState.user.token,
            widget.eventId,
          );
          setState(() {
            _buttonText = 'Register';
            _buttonColor = Colors.green;
          });
          updateButtonText(_buttonText, _buttonColor);
        } else {
          // user is not registered, so register them
          await context.read<EventCubit>().registerEvent(
            userState.user.token,
            widget.eventId,
          );
          setState(() {
            _buttonText = 'Unregister';
            _buttonColor = Colors.red;
          });
          updateButtonText(_buttonText, _buttonColor);
        }
      } else {
        Navigator.pushNamed(context, '/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[500],
        child: Stack(
          children: [
            event.eventImage != null
                ? Material(
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(event.eventImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Container(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_outlined),
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                0.0,
                                10.0,
                              ),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      event.title,
                                      style: textTheme.titleSmall?.copyWith(
                                        color: const Color(0xFFEB4A5A),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02),
                                  Text(
                                    DateFormat.yMMMMEEEEd()
                                        .format(event.date),
                                    style: textTheme.titleSmall?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: screenWidth * 0.01),
                                      Text(
                                        '${event.startTime}${event.endTime != null ? ' - ${event.endTime}' : ''}',
                                        style: textTheme.titleSmall?.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.1),
                                      Expanded(
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              event.location ?? '',
                                              style: textTheme.titleSmall
                                                  ?.copyWith(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //button
                              SizedBox(height: screenHeight * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _registerOrUnregister();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: _buttonColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(_buttonText,
                                              style: textTheme.titleSmall
                                                  ?.copyWith(
                                                color: Colors.white,
                                              )
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Text(
                                    event.description,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              Row(
                                children: [
                                  event.isDone == 'true'
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.timer,
                                          color: Colors.grey,
                                        ),
                                  SizedBox(width: screenWidth * 0.03),
                                  Text(
                                    event.isDone == 'true'
                                        ? 'Done'
                                        : 'Pending',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: event.isDone == 'true'
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.category,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: screenWidth * 0.03),
                                  Text(
                                    event.type,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

