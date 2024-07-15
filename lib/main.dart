import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/common/utilities.dart';
import 'package:partyly_app/mobile/pages/home-page.dart';
import 'package:partyly_app/mobile/pages/login-page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:partyly_app/mobile/pages/main-scaffold.dart';
import 'package:partyly_app/mobile/pages/register-page.dart';
import 'package:partyly_app/models/providers/cart-provider.dart';
import 'package:partyly_app/models/providers/user-provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAPdSsck1Xe5r7ww1mLHBpPl08460sFCfo",
            authDomain: "partyly-ef121.firebaseapp.com",
            projectId: "partyly-ef121",
            storageBucket: "partyly-ef121.appspot.com",
            messagingSenderId: "875524811620",
            appId: "1:875524811620:web:2f116d0dd4bbe36ff4e871",
            measurementId: "G-JVXJ3GM7ML"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
      )
    ],
    child: const MyApp(),
  ));
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
              return const MainScaffold();
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
