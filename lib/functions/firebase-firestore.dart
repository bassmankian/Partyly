import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyly_app/models/event-model.dart';

class FirestoreService {
  Future<void> addUser(
      String name, String mobile, String email, String userId) async {
    final userData = {
      'name': name,
      'mobile': mobile,
      'email': email,
    };
    await addDocument('users', userData, userId);
    print('User added successfully with ID: $userId');
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

      print("Event added successfully");
    } catch (error) {
      print("Error adding event: $error"); // Handle the error appropriately
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

        return Event.fromJson(eventData);
      } else {
        return null; // Event not found
      }
    } catch (error) {
      print("Error fetching event: $error");
      return null;
    }
  }

  Future<List<Event>> getAllEvents() async {
    try {
      final eventsCollection = FirebaseFirestore.instance.collection('events');
      final querySnapshot = await eventsCollection.get();

      final events = querySnapshot.docs.map((doc) {
        final eventData = doc.data();
        eventData['eventId'] = doc.id; // Add the document ID
        return Event.fromJson(eventData);
      }).toList();

      return events;
    } catch (error) {
      print("Error fetching events: $error");
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
        eventData['eventId'] = doc.id;
        return Event.fromJson(eventData);
      }).toList();

      return events;
    } catch (error) {
      print("Error fetching upcoming events: $error");
      return [];
    }
  }
}
