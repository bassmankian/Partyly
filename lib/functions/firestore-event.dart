import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyly_app/models/event-model.dart';
import 'package:partyly_app/models/ticket-model.dart';

class FirestoreEvents {
// get event from firebase
  Future<Event?> getEvent(String eventId) async {
    try {
      final eventsCollection = FirebaseFirestore.instance.collection('events');
      final eventDoc = await eventsCollection.doc(eventId).get();

      if (eventDoc.exists) {
        final eventData = eventDoc.data()!;
        // Add the document ID to the eventData
        eventData['eventId'] = eventDoc.id; // This is the crucial change

        return Event.fromJson(eventData, eventId);
      } else {
        return null; // Event not found
      }
    } catch (error) {
      return null;
    }
  }

  Future<List<Event>> getAllEvents() async {
    try {
      final eventsCollection = FirebaseFirestore.instance.collection('events');
      final querySnapshot = await eventsCollection.get();

      final events = querySnapshot.docs.map((doc) {
        final eventData = doc.data();
        return Event.fromJson(eventData, doc.id);
      }).toList();

      return events;
    } catch (error) {
      return []; // Return an empty list in case of an error
    }
  }

  Future<Event?> getAllEventsFomUser(String userId) async {
    try {
      final eventsCollection = FirebaseFirestore.instance.collection('events');
      final eventDoc =
          await eventsCollection.where('organizerId', isEqualTo: userId).get();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Event>> getUpcomingEvents() async {
    try {
      final now = Timestamp.now();
      final eventsCollection = FirebaseFirestore.instance.collection('events');
      final querySnapshot = await eventsCollection
          .where('startDate', isGreaterThan: now) // Filter by startDate
          .get();

      final events = querySnapshot.docs.map((doc) {
        final eventData = doc.data();
        // eventData['eventId'] = doc.id;
        return Event.fromJson(eventData, doc.id);
      }).toList();

      return events;
    } catch (error) {
      return [];
    }
  }

// get document Id by title in document
  Future<String> getEventIdByName(String eventName) async {
    try {
      // 1. Query for the event document by name
      QuerySnapshot eventSnapshot = await FirebaseFirestore.instance
          .collection('events')
          .where('name', isEqualTo: eventName)
          .get();

      if (eventSnapshot.docs.isNotEmpty) {
        DocumentSnapshot eventDoc = eventSnapshot.docs.first;

        // 2. Get the document ID from the event document
        String eventId = eventDoc.id;

        return eventId;
      } else {
        throw Exception('Event not found');
      }
    } catch (error) {}
    return '';
  }

  Future<List<TicketShortInfo>> getEventTicketsByName(String eventName) async {
    try {
      final eventId = await getEventIdByName(eventName);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .collection('tickets')
          .get();

      final tickets = querySnapshot.docs
          .map((doc) {
            final ticket = doc.data() as Map<String, dynamic>;
            final ticketWithId = {...ticket, 'ticketId': doc.id};

            return TicketShortInfo.fromJson(ticketWithId);
          })
          .whereType<TicketShortInfo>()
          .toList(); // Filter out potential null values);

      return tickets;
    } catch (error) {
      print(
          "Error fetching tickets for event $eventName: $error"); // Print the full error object
      print(error.runtimeType); // Print the error type
      return [];
    }
  }
}
