import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyly_app/models/event-model.dart';
import 'package:partyly_app/models/ticket-model.dart';
import 'package:partyly_app/models/user-model.dart';

class FirestoreTicekts {
  // get event ticket info
  Future<List<TicketShortInfo>> getEventTicketInfo(String docId) async {
    try {
      final eventsCollection = FirebaseFirestore.instance.collection('events');
      final querySnapshot =
          await eventsCollection.doc(docId).collection('tickets').get();

      final ticketsInfos = querySnapshot.docs.map((doc) {
        final ticket = doc.data();
        return TicketShortInfo.fromJson(ticket); // Corrected type
      }).toList();

      return ticketsInfos; // Add return statement here
    } catch (error) {
      return [];
    }
  }

  addTicket(Ticket ticket) async {
    final eventsCollection = FirebaseFirestore.instance.collection('tickets');
    eventsCollection.add(ticket.toMap());
  }

  Future<Ticket> generateTicket(
      TicketShortInfo shortTicket, Event event, User user) async {
    try {
      final ticket = Ticket(
          ticketType: shortTicket.type,
          eventId: event.docId!,
          userId: user.docid!,
          name: user.name,
          price: shortTicket.price,
          status: 'purcahsed',
          datePurchased: Timestamp.now(),
          quantity: 2);

      print('The ticket data is: $ticket');

      // await addTicket(ticket);

      return ticket;
    } catch (e) {
      throw Exception('Error generating ticket: $e');
    }
  }
}
