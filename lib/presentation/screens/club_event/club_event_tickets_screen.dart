import 'package:esjourney/presentation/widgets/club_event/horizontal_ticket_types.dart';
import 'package:esjourney/presentation/widgets/club_event/vertical_ticket_types.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:flutter/material.dart';


class ClubEventTicketsScreen extends StatelessWidget {
  const ClubEventTicketsScreen({super.key, this.clubEvent});

  final clubEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.ktickets),
        ),
        body: Column(
          children: [
            Expanded(flex: 4, child: VerticalTicketTypes(clubEvent: clubEvent)),
            Expanded(flex: 2, child: HorizontalTicketTypes(clubEvent: clubEvent)),
          ],
        ));
  }
}
