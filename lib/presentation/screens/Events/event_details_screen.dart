import 'package:esjourney/data/models/events/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../logic/cubits/events/event_cubit.dart';
import '../../../logic/cubits/user/user_cubit.dart';
import '../../../logic/cubits/user/user_state.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

var _buttonText = 'Register';
var _buttonColor = Colors.green;

class _EventDetailsState extends State<EventDetails> {

  @override
  void initState() {
    super.initState();
    final userState = context.read<UserCubit>().state;
    if (userState is UserLogInSuccess) {
      final userEvents = userState.user.events?.map((e) => e.id).toList();
      if (userEvents?.contains(widget.event.id) ?? false) {
        _buttonText = 'Unregister';
        _buttonColor = Colors.red;
      }else{
        _buttonText = 'Register';
        _buttonColor = Colors.green;
      }
    } else {
      Navigator.pushNamed(context, '/');
    }
  }


  void updateButtonText(String text, MaterialColor color) {
    setState(() {
      _buttonText = text;
      _buttonColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        color: Colors.grey[500],
        child: Stack(
          children: [
            widget.event.eventImage != null
                ? Material(
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.event.eventImage!),
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
                                      widget.event.title,
                                      style: textTheme.titleSmall?.copyWith(
                                        color: const Color(0xFFEB4A5A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
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
                                        .format(widget.event.date),
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
                                        '${widget.event.startTime}${widget.event.endTime != null ? ' - ${widget.event.endTime}' : ''}',
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
                                              widget.event.location ?? '',
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
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: _buttonColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (_buttonText == 'Register') {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  bool isChecked = false;
                                                  return StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          'Registration Requirements',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Please read and accept the requirements to register.',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Text(
                                                                  widget.event
                                                                      .requirementsDescription!,
                                                                  style: textTheme
                                                                      .bodyMedium
                                                                      ?.copyWith(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                ),
                                                              ),
                                                            ),
                                                            CheckboxListTile(
                                                              title: const Text(
                                                                  'I accept the requirements.'),
                                                              value: isChecked,
                                                              onChanged: (bool?
                                                                  value) {
                                                                setState(() {
                                                                  isChecked =
                                                                      value ??
                                                                          false;
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: const Text(
                                                                'Cancel'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: isChecked
                                                                ? () {
                                                                    setState(
                                                                        () {
                                                                      _buttonColor =
                                                                          Colors
                                                                              .red;
                                                                      _buttonText =
                                                                          'Unregister';
                                                                      print(
                                                                          _buttonText);
                                                                    });
                                                                    updateButtonText(
                                                                        _buttonText,
                                                                        _buttonColor);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  }
                                                                : null,
                                                            child: const Text(
                                                                'Confirm'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            } else {
                                              setState(() {
                                                _buttonText = 'Register';
                                                _buttonColor = Colors.green;
                                                print(_buttonText);
                                              });
                                              updateButtonText(
                                                  _buttonText, _buttonColor);
                                            }
                                          },
                                          child: Text(_buttonText,
                                              style:
                                                  textTheme.bodyLarge?.copyWith(
                                                color: Colors.white,
                                              )),
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
                                    widget.event.description,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              Row(
                                children: [
                                  widget.event.isDone == 'true'
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
                                    widget.event.isDone == 'true'
                                        ? 'Done'
                                        : 'Pending',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: widget.event.isDone == 'true'
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
                                    widget.event.type,
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
