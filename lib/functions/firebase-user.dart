import 'dart:math';

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

  Future<User> getUser(String userId) async {
    try {
      final querySnapshot = await _firestore.doc(userId).get();
      // print(querySnapshot.data());

      if (querySnapshot.exists) {
        final userData = querySnapshot.data();
        return User.fromJson(userData!);
      } else {}
    } catch (e) {
      print(e);
    }
    throw e;
  }
}
