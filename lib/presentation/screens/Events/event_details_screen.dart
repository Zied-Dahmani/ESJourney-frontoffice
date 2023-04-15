import 'package:esjourney/data/models/events/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../logic/cubits/events/event_cubit.dart';
import '../../../logic/cubits/user/user_cubit.dart';
import '../../../logic/cubits/user/user_state.dart';
import 'meeting/meeting_screen.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  get screenHeight => MediaQuery.of(context).size.height;
  get screenWidth => MediaQuery.of(context).size.width;
  get textTheme => Theme.of(context).textTheme;
  late Event event = widget.event;
  String _buttonText = 'Register';
  MaterialColor _buttonColor = Colors.green;
  //meeting
  bool showJoinMeetingButton = false;


  void updateButtonText(String text, MaterialColor color) {
    setState(() {
      _buttonText = text;
      _buttonColor = color;
    });
  }


  void _fetchEvent() async {
    final userState = context.read<UserCubit>().state;
    if (userState is! UserLogInSuccess) return;
    final token = userState.user.token;
    await context.read<UserCubit>().refreshUserData(token!);
    print('user id: ${userState.user.id}');
    final isRegistered =
        userState.user.events?.any((element) => element.id == event.id) ?? false;
    final isMeeting = event.location == 'meeting';
    final eventStartTime = DateFormat.Hm().parse(event.startTime);
    final eventEndTime = DateFormat.Hm().parse(event.endTime);
    final eventDateTime = event.date
        .add(Duration(hours: eventStartTime.hour - 1, minutes: eventStartTime.minute));
    final eventEndDateTime = event.date
        .add(Duration(hours: eventEndTime.hour - 1, minutes: eventEndTime.minute));
    final currentTime = DateTime.now();

    setState(() {
      if (isRegistered) {
        updateButtonText('Unregister', Colors.red);
      } else {
        updateButtonText('Register', Colors.green);
      }
      print('isRegistered: $isRegistered');

      print('eventStartTime: $eventStartTime');
      print('eventEndTime: $eventEndTime');
      print('event date time: $eventDateTime');
      print('event end date time: $eventEndDateTime');
      print('date correct? ${event.date == DateTime.now()}');
      print('currentTime: $currentTime');
      print('testing ${eventDateTime.isBefore(currentTime)}');
      // Show Join Meeting button if event is registered, has a location of "meeting", and has started
      //to add later eventStartTime.isBefore(currentTime)
      if (isRegistered && isMeeting && eventDateTime.isBefore(currentTime.toUtc()) && eventEndDateTime.isAfter(currentTime.toUtc())) {
        showJoinMeetingButton = true;
      } else {
        showJoinMeetingButton = false;
      }
      print(isRegistered);
      print(isMeeting);
      print('start time');
      print(eventDateTime.isBefore(currentTime));
      print('end time');
      print(eventEndDateTime.isAfter(currentTime));
      print('current time: ${currentTime.toUtc()}');
      print('showJoinMeetingButton: $showJoinMeetingButton');
    });
  }








  @override
  void initState() {
    super.initState();
    _fetchEvent();
  }


  void _joinMeeting() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => MeetingPage(event: event),
    //   ),
    // );
  }

  Future<void> _registerOrUnregister() async {
    final userState = context.read<UserCubit>().state;
    if (userState is UserLogInSuccess) {
      if (_buttonText == 'Register') {
        final requirementsDescription = widget.event.requirementsDescription;
        if (requirementsDescription.isNotEmpty) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              bool isChecked = false;
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: const Text(
                      'Registration Requirements',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Please read and accept the requirements to register.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Text(
                              requirementsDescription,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        CheckboxListTile(
                          title: Text('I accept the requirements.'),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: Text('Register'),
                        onPressed: isChecked
                            ? () async {
                                await context.read<EventCubit>().registerEvent(
                                      userState.user.token!,
                                      widget.event.id,
                                    );
                                setState(() {
                                  updateButtonText('Unregister', Colors.red);
                                });
                                Navigator.of(context).pop();
                              }
                            : null,
                      ),
                    ],
                  );
                },
              );
            },
          );
          setState(() {
            final isMeeting = widget.event.location == 'meeting';
            final eventStartTime = DateFormat.Hm().parse(widget.event.startTime);
            final currentTime = DateTime.now();
            if (isMeeting && widget.event.date.isBefore(currentTime)) {
              showJoinMeetingButton = true;
            }
          });
        } else {
          await context.read<EventCubit>().registerEvent(
                userState.user.token!,
                widget.event.id,
              );
          setState(() {
            updateButtonText('Unregister', Colors.red);
          });
        }
      } else {
        await context.read<EventCubit>().registerEvent(
              userState.user.token!,
              widget.event.id,
            );
        setState(() {
          showJoinMeetingButton = false;
          updateButtonText('Register', Colors.green);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: event == null
          ? const CircularProgressIndicator()
          : Container(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                    Icons.arrow_back_ios_new_outlined),
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
                                            style:
                                                textTheme.titleSmall?.copyWith(
                                              color: const Color(0xFFEB4A5A),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                              style: textTheme.titleSmall
                                                  ?.copyWith(
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
                                                  Tooltip(
                                                    message:
                                                        event.location,
                                                    child: Text(
                                                      event.location,
                                                      style: textTheme
                                                          .titleSmall
                                                          ?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
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
                                          builder: (BuildContext context, StateSetter setState) {
                                            return Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _registerOrUnregister();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: _buttonColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                                child: Text(
                                                  _buttonText,
                                                  style: textTheme.titleSmall?.copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        if (showJoinMeetingButton)
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: _joinMeeting,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text(
                                                'Join Meeting',
                                                style: textTheme.titleSmall?.copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
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
