// Event Card Widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/events/event_model.dart';

// Event Card Widget
class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                EventInfo(event: event),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Event Info Widget
class EventInfo extends StatelessWidget {
  final Event event;

  const EventInfo({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(icon: Icons.calendar_today, info: DateFormat('dd/MM/yyyy').format(event.date)),
        const SizedBox(height: 8),
        InfoRow(icon: Icons.access_time, info: '${event.startTime} - ${event.endTime}'),
        const SizedBox(height: 8),
        InfoRow(icon: Icons.location_on, info: event.location),
        const SizedBox(height: 8),
      ],
    );
  }
}

// Info Row Widget
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String info;

  const InfoRow({Key? key, required this.icon, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.white),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              info,
              style: TextStyle(fontSize: 16, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}


