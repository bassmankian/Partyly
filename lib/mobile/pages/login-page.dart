import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/common/utilities.dart';
import 'package:partyly_app/functions/firebase_auth.dart';
import 'package:partyly_app/mobile/pages/register-page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String pageRoute = '/loginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor, // Background color from the image
      body: Center(
        child: SingleChildScrollView(
          // Allow scrolling if content overflows
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'PARTYLY',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                    fontFamily: 'YourCustomFont', // Replace with your font
                  ),
                ),
                const Text(
                  'Party Crazily',
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontFamily: 'YourCustomFont',
                  ),
                ),
                const SizedBox(height: 40), // Add spacing
                const Text(
                  'Welcom to Partyly',
                  style: TextStyle(
                    fontSize: 24,
                    color: textColor,
                    fontFamily: 'YourCustomFont',
                  ),
                ),
                const Text(
                  'Where we all believe we only live once',
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                const SizedBox(height: 40),
                _buildTextField('Email Address', _emailController, Icons.email),
                _buildTextField('Password', _passwordController, Icons.lock,
                    obscureText: true),
                SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle "Reset Password" logic
                        SnackBarHelper.showSnackBar('it works');
                      },
                      child: const Text('Reset Password',
                          style: TextStyle(
                              color: accentColor, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: containerColor,
                    backgroundColor: accentColor,
                    minimumSize: const Size(double.infinity, 64),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          16.0), // Adjust the radius as needed
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process login
                      FirebaseAuthService().signInWithEmailAndPassword(
                          _emailController.text, _passwordController.text);
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Handle "Register now" logic
                    Navigator.pushReplacementNamed(
                        context, RegisterPage.pageRoute);
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Not a member yet? ',
                            style: TextStyle(color: textColor)),
                        TextSpan(
                            text: 'Register now',
                            style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Image.asset(
                  'assets/button/login-with-google.png',
                  height: 50,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: textColor), // Set text color to white
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
                color: textSecendaryColor), // Set label color to grey
            prefixIcon: Icon(icon, color: textSecendaryColor),
            filled: true,
            fillColor:
                containerColor, // Slightly lighter background for the field
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            // Additional validation can be added here (e.g., email format)
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton(String label, String imagePath) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: mainColor,
        backgroundColor: textColor,
        minimumSize: const Size(150, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onPressed: () {
        // Handle social login logic
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, height: 24), // Load your social media logo
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
