import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:partyly_app/functions/firebase-firestore.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/models/event-model.dart';
import 'package:partyly_app/models/ticket-model.dart';
import 'package:partyly_app/widgets/ticket.dart'; // Your event model

class EventDetailsPage extends StatefulWidget {
  final Event event;

  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool _isLoading = true;
  List<ticketShortInfo> _ticektsInfo = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData(String eventId) async {
    _ticektsInfo = await FirestoreService().getEventTicketInfo();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    late final event = widget.event;

    return Scaffold(
        backgroundColor: mainColor, // Set the background color to black
        body:
            // _isLoading
            //     ? const Center(child: CircularProgressIndicator()) // Loading state
            //     :
            SingleChildScrollView(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200, // Adjust as needed
                flexibleSpace: FlexibleSpaceBar(
                  background: widget.event.thumbnailUrl != null
                      ? Image.network(
                          widget.event.thumbnailUrl!,
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
                            widget.event.category,
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
                                      formatMonth(
                                          widget.event.startDate.toDate()),
                                      style: const TextStyle(
                                        color: textColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      formatDayDate(
                                          widget.event.startDate.toDate()),
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
                                    widget.event.name,
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
                                        formatTime(
                                            widget.event.startTime.toDate()),
                                        style: const TextStyle(
                                            color: textColor, fontSize: 16),
                                      ),
                                      Text(
                                        ' | ${formatTime(widget.event.endTime.toDate())}',
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
                        const SizedBox(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // image holder container
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: containerColor),
                          width: double.infinity,
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.event.imageUrls!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      widget.event.imageUrls![index].toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tickets',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                        const SizedBox(
                          height: 16,
                        ),

                        TicketCard(
                          price: _ticektsInfo[0].price,
                          type: _ticektsInfo[0].type,
                        ),
                        TicketCard(
                          price: _ticektsInfo[1].price,
                          type: _ticektsInfo[1].type,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ));
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