import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  final String eventId;
  final String title;
  final DateTime date;
  final String startTime;
  final String? endTime;
  final String description;
  final String isDone;
  final String type;
  final String? eventImage;
  final String? location;
  final String? requirementsDescription;

  const EventDetails({
    required this.eventId,
    required this.title,
    required this.date,
    required this.startTime,
    this.endTime,
    required this.description,
    required this.isDone,
    required this.type,
    this.eventImage,
    this.location,
    this.requirementsDescription,
  });

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

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
            widget.eventImage != null
                ? Material(
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.eventImage!),
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
                                      widget.title,
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
                                    DateFormat.yMMMMEEEEd().format(widget.date),
                                    style: textTheme.titleSmall?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                      Text(
                                        '${widget.startTime}${widget.endTime != null ? ' - ${widget.endTime}' : ''}',
                                        style: textTheme.titleSmall?.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1),
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        widget.location ?? '',
                                        style: textTheme.titleSmall?.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //button
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {

                                      var buttonText = 'Register';
                                      return ElevatedButton(

                                        onPressed: () {
                                          if (buttonText == 'Register') {
                                            showDialog(
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
                                                                widget.requirementsDescription!,
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
                                                              ? () {
                                                            setState(() {
                                                              buttonText = 'Unregister';
                                                              print('buttonText updated to $buttonText');
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
                                          } else {
                                            setState(() {
                                              buttonText = 'Register';
                                              print('buttonText updated to $buttonText');
                                            });
                                          }
                                        },
                                        child: Text(buttonText),
                                      );
                                    },
                                  ),


                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Text(
                                    widget.description,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),

                              Row(
                                children: [
                                  widget.isDone == 'true'
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
                                    widget.isDone == 'true'
                                        ? 'Done'
                                        : 'Pending',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: widget.isDone == 'true'
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.category,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: screenWidth * 0.03),
                                  Text(
                                    widget.type,
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
