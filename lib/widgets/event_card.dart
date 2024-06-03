import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/models/event-model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: containerColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Event image
            event.thumbnailUrl != null
                ? ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200, maxHeight: 120),
                    child: Image.network(
                      event.thumbnailUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                  ),

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.calendar_today, color: accentColor, size: 8),
                const SizedBox(width: 4),
                Text(
                  formatDate(event.startDate.toDate())
                      .toString(), // Convert Timestamp to DateTime
                  style: const TextStyle(color: accentColor, fontSize: 10),
                ),

                // start and end time
                const SizedBox(width: 4),
                const Icon(Icons.access_time, color: accentColor, size: 8),
                Text(
                  formatTime(event.startTime.toDate())
                      .toString(), // Convert Timestamp to DateTime
                  style: const TextStyle(color: accentColor, fontSize: 10),
                ),
                Text(
                  ' | ${formatTime(event.endTime.toDate())}', // Convert Timestamp to DateTime
                  style: const TextStyle(color: accentColor, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                event.name, // Use event name for title
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.whatshot, color: Color(0xFFF25252)),
                const SizedBox(width: 4),
                Text(event.organizerId,
                    style: const TextStyle(
                        color: Color(
                            0xFFF25252))), // Assuming organizerId holds organizer name
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: mainColor,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text("Get Tickets"),
            ),
          ],
        ),
      ),
    );
  }

  // Replace these with your actual formatting functions
  String formatDate(DateTime date) {
    // Implement your date formatting logic here
    return DateFormat('EEE, dd MMM').format(date); // Example format
  }

  String formatTime(DateTime time) {
    // Implement your time formatting logic here
    return DateFormat('HH:mm').format(time); // Example format
  }
}
