import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/functions/firestore-event.dart';
import 'package:partyly_app/mobile/pages/cart-details.dart';
import 'package:partyly_app/models/event-model.dart';
import 'package:partyly_app/models/providers/cart-provider.dart';
import 'package:partyly_app/models/providers/user-provider.dart';
import 'package:partyly_app/models/ticket-model.dart';
import 'package:partyly_app/widgets/buttons.dart';
import 'package:partyly_app/widgets/ticket.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;

  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

List<int> selectedTicket = [];

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  void dispose() {
    selectedTicket.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final event = widget.event;
    void onpressedButton() {
      showModalBottomSheet(
          isScrollControlled: true,
          enableDrag: true,
          showDragHandle: true,
          context: context,
          builder: (ctx) {
            return CartDetailPage();
          });
    }

    return Scaffold(
        backgroundColor: mainColor, // Set the background color to black
        body: CustomScrollView(
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            fontSize: 14,
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
                        height: 200,
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
                                    event.imageUrls![index].toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      // Return a placeholder widget, error message, or retry logic
                                      return const Text('Image failed to load');
                                    },
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
                      buildTicketCard(event),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomElevatedButton(
                          text: 'View cart', onPressed: onpressedButton)
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ));
  }

  FutureBuilder<List<TicketShortInfo>> buildTicketCard(Event event) {
    final user = Provider.of<UserProvider>(context).user;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    int quantity = 0;

    return FutureBuilder<List<TicketShortInfo>>(
      future: FirestoreEvents().getEventTicketsByName(event.name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Error fetching tickets');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Check for non-empty data
          final tickets = snapshot.data!;
          return StatefulBuilder(
            builder: (context, setState) => Stack(children: [
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tickets.length,
                itemBuilder: (context, index) => GestureDetector(
                  onLongPress: () {
                    // final Ticket ticket = await FirestoreTicekts()
                    //     .generateTicket(tickets[index], event, user!);
                  },
                  onTap: () {
                    setState(() {
                      if (selectedTicket.contains(index)) {
                        cartProvider.removeTicket(tickets[index]);
                        selectedTicket.remove(index);
                      } else {
                        selectedTicket.add(index);
                        cartProvider.addTicket(
                            tickets[index], ++quantity, event);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: selectedTicket.contains(index)
                          ? BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              border: Border.all(color: accentColor, width: 2))
                          : null,
                      child: TicketCard(
                        ticket:
                            tickets[index], // Provide default values if null
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          );
        } else {
          return const Center(child: Text('No tickets found for this event'));
        }
      },
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
