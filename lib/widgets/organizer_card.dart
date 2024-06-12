import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/mobile/pages/evenet_details_page.dart';

class OrganizerCard extends StatelessWidget {
  const OrganizerCard({
    super.key,
    required this.widget,
  });

  final EventDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: containerColor,
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              minRadius: 25,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.event.organizerId),
                  const Text('8 upcoming events'),
                ],
              ),
            ),
            const Text('Rating')
          ],
        ),
      ),
    );
  }
}
