import 'package:flutter/material.dart';
import 'package:partyly_app/functions/firebase-user.dart';
import 'package:partyly_app/functions/firebase_auth.dart';
import 'package:partyly_app/models/user-model.dart';
import 'package:partyly_app/widgets/buttons.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  String? userId = FirebaseAuthService().getCurrentUserId();
  User? user; // To store the fetched user data

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Call the function to fetch data in initState
  }

  Future<void> _fetchUserData() async {
    try {
      final userData = await FirestoreUser().getUser(userId!);
      setState(() {
        user = userData;
      });
    } catch (error) {
      // Handle potential errors during the Firestore fetch
      print('Error fetching user: $error');
      // Potentially show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: user == null
            ? const CircularProgressIndicator() // Show loading indicator
            : MePageWidgets(user: user) // Access the user's name if available
        );
  }
}

class MePageWidgets extends StatelessWidget {
  const MePageWidgets({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome dear ${user?.name}!',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('User access is ${user?.type}'),
          CustomElevatedButton(text: 'Add event', onPressed: () {})
        ],
      ),
    );
  }
}
