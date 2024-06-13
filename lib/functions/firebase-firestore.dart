import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyly_app/models/event-model.dart';

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
}
