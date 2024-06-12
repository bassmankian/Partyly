import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyly_app/models/event-model.dart';
import 'package:partyly_app/models/ticket-model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      String name, String mobile, String email, String userId) async {
    final userData = {
      'name': name,
      'mobile': mobile,
      'email': email,
    };
    await addDocument('users', userData, userId);
  }

  Future<DocumentReference> addDocument(
      String collectionPath, Map<String, dynamic> data, String id) async {
    final collectionRef = _firestore.collection(collectionPath);
    final docRef = collectionRef
        .doc(id); // Create a DocumentReference with the specified ID
    await docRef.set(data); // Set the data in the document
    return docRef; // Return the DocumentReference
  }

// add event to firebase
  Future<void> addEvent(Event event) async {
    try {
      // 1. Get a reference to the Firestore collection
      final eventsCollection = FirebaseFirestore.instance.collection('events');

      // 3. Add the event to Firestore
      await eventsCollection.doc().set(event.toJson());
    } catch (error) {
      // Handle the error appropriately
    }
  }

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
        // eventData['eventId'] = doc.id; // Add the document ID
        return Event.fromJson(eventData, doc.id);
      }).toList();

      return events;
    } catch (error) {
      return []; // Return an empty list in case of an error
    }
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
    final eventId = await getEventIdByName(eventName);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .collection('tickets')
        .get();

    final tickets = querySnapshot.docs
        .map((doc) {
          final ticket = doc.data() as Map<String, dynamic>;

          return TicketShortInfo.fromJson(ticket);
        })
        .whereType<TicketShortInfo>()
        .toList(); // Filter out potential null values);
    if (tickets.isEmpty) {
      return [];
    }
    return tickets;
  }
}
