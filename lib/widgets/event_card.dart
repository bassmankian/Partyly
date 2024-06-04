import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../common/app_colors.dart';
import '../models/event-model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.61,
      child: SizedBox(
        width: 200,
        child: Card(
          color: containerColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event image with Flexible
                Flexible(
                  flex: 5,
                  child: event.thumbnailUrl != null
                      ? AspectRatio(
                          aspectRatio: 1.61 / 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              event.thumbnailUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey,
                              ),
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
                ),

                const SizedBox(height: 8),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_today,
                          color: accentColor, size: 8),
                      const SizedBox(width: 4),
                      Text(
                        formatDate(event.startDate.toDate()),
                        style:
                            const TextStyle(color: accentColor, fontSize: 10),
                      ),

                      // start and end time (conditional display)
                      ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.access_time,
                            color: accentColor, size: 8),
                        Text(
                          formatTime(event.startTime.toDate()),
                          style:
                              const TextStyle(color: accentColor, fontSize: 10),
                        ),
                        Text(
                          ' | ${formatTime(event.endTime.toDate())}',
                          style:
                              const TextStyle(color: accentColor, fontSize: 10),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Event Name with Flexible
                Flexible(
                  flex: 2,
                  child: Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      const Icon(Icons.whatshot, color: Color(0xFFF25252)),
                      const SizedBox(width: 4),
                      Text(
                        event.organizerId,
                        style: const TextStyle(color: Color(0xFFF25252)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // "Get Tickets" Button with Flexible
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper functions
  String formatDate(DateTime date) {
    return DateFormat('EEE, dd MMM').format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
}
