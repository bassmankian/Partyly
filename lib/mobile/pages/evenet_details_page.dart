import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/models/event-model.dart'; // Your event model

class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor, // Set the background color to black
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200, // Adjust as needed
            flexibleSpace: FlexibleSpaceBar(
              background: event.thumbnailUrl != null
                  ? Image.network(
                      event.thumbnailUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(color: Colors.grey),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        event.category,
                        style: const TextStyle(
                          fontSize: 18,
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Title, Address, and Time
                    Row(
                      children: [
                        Container(
                          width: 80,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  formatMonth(event.startDate.toDate()),
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  formatDayDate(event.startDate.toDate()),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: accentColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 16), // Spacing

                        Expanded(
                          // Allow title and details to take remaining space
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: accentColor, size: 24),
                                  SizedBox(width: 4),
                                  Text(
                                    'Address of the event',
                                    style: TextStyle(
                                        color: textColor, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.access_time,
                                      color: accentColor, size: 24),
                                  const SizedBox(width: 4),
                                  Text(
                                    formatTime(event.startTime.toDate()),
                                    style: const TextStyle(
                                        color: textColor, fontSize: 16),
                                  ),
                                  Text(
                                    ' | ${formatTime(event.endTime.toDate())}',
                                    style: const TextStyle(
                                        color: textColor, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Card(
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
                                  Text(event.organizerId),
                                  const Text('8 upcoming events'),
                                ],
                              ),
                            ),
                            const Text('Rating')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // Helper functions (unchanged)
  String formatDayDate(DateTime date) {
    return DateFormat('dd').format(date);
  }

  String formatMonth(DateTime date) {
    return DateFormat('MMM').format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
}
