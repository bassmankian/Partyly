import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:partyly_app/functions/firebase-firestore.dart';

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

  Future<Map<String, dynamic>> getUser(String userId) async {
    try {
      final querySnapshot = await _firestore.doc(userId).get();
      print(querySnapshot.data());

      if (querySnapshot.exists) {
        final userData = querySnapshot.data();
        return userData!;
      } else {
        return {};
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
