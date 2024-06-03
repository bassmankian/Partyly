import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/common/utilities.dart';
import 'package:partyly_app/pages/home-page.dart';
import 'package:partyly_app/pages/login-page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:partyly_app/pages/register-page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: SnackBarHelper.scaffoldMessengerKey,
      theme: appTheme,
      // initialRoute: '/loginPage', // Set the initial route
      routes: {
        '/loginPage': (context) =>
            const LoginPage(), // Route for the login page
        '/registerPage': (context) => const RegisterPage(),
        '/homePage': (context) => HomePage(),
      },
      home: StreamBuilder<firebase_auth.User?>(
        stream: firebase_auth.FirebaseAuth.instance
            .authStateChanges(), // Stream user auth changes
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // User is logged in
            if (snapshot.hasData) {
              return HomePage();
            }
            // User is not logged in
            else {
              return const LoginPage();
            }
          }

          // While waiting for the connection to establish, show a loading indicator
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
