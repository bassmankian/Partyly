import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyly_app/functions/firebase-firestore.dart';
import 'package:partyly_app/models/user-model.dart';

class FirestoreUser {
  final _firestore = FirebaseFirestore.instance.collection('users');
  Future<void> addUser(
      String name, String mobile, String email, String userId) async {
    final userData = {
      'name': name,
      'mobile': mobile,
      'email': email,
    };
    await FirestoreService().addDocument('users', userData, userId);
  }

  Future<User?> getUser(String userId) async {
    try {
      final querySnapshot = await _firestore.doc(userId).get();
      // print(querySnapshot.data());

      if (querySnapshot.exists) {
        final userData = querySnapshot.data() as Map<String, dynamic>;
        // 2. Create a new Map to add docId
        final userDataWithId = {
          ...userData, // Spread existing data
          'docid': querySnapshot.id, // Add the document ID
        };

        return User.fromJson(userDataWithId);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      // Handle FirebaseException
      print('Firebase Auth Error: ${e.code}: ${e.message}');
      return null;
    } catch (e) {
      // Handle other exceptions
      print('Other Error fetching user: $e');
      return null;
    }
  }
}
