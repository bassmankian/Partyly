import 'package:cloud_firestore/cloud_firestore.dart';

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
}
