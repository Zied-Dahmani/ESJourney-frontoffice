import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  final String eventId;
  final String title;
  final DateTime date;
  final String startTime;
  final String? endTime;
  final String description;
  final String isDone;
  final String type;
  final String? eventImage;

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
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          eventImage != null
              ? Container(
                  height: screenHeight * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(eventImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                  SizedBox(height: screenHeight * 0.08),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: textTheme.subtitle2?.copyWith(
                                      color: const Color(0xFFEB4A5A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  DateFormat.yMMMMEEEEd().format(date),
                                  style: textTheme.subtitle2?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  '$startTime${endTime != null ? ' - $endTime' : ''}',
                                  style: textTheme.subtitle2?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Expanded(
                              flex: 1,
                              child: SingleChildScrollView(
                                child: Text(
                                  description,
                                  style: textTheme.bodyText2?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Row(
                              children: [
                                isDone == 'true'
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
                                  isDone == 'true' ? 'Done' : 'Pending',
                                  style: textTheme.bodyText2?.copyWith(
                                    color: isDone == 'true'
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Row(
                              children: [
                                const Icon(
                                  Icons.category,
                                  color: Colors.black,
                                ),
                                SizedBox(width: screenWidth * 0.03),
                                Text(
                                  type,
                                  style: textTheme.bodyText2?.copyWith(
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
    );
  }
}
