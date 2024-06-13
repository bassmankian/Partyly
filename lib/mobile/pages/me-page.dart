import 'package:flutter/material.dart';
import 'package:partyly_app/functions/firebase-user.dart';
import 'package:partyly_app/functions/firebase_auth.dart';
import 'package:partyly_app/models/user-model.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  String? userId = FirebaseAuthService().getCurrentUserId();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      // Use FutureBuilder to handle async operation
      future: FirestoreUser()
          .getUser(userId!), // Use '!' if you're sure userId won't be null
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data;
          return Center(child: Text(user!['name'])); // Access the user's name
        } else {
          return const Text('User not found');
        }
      },
    );
  }
}
