import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/functions/firebase-firestore.dart';
import 'package:partyly_app/functions/firebase_auth.dart';
import 'package:partyly_app/pages/login-page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const String pageRoute = '/registerPage';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'PARTYLY',
          style: TextStyle(fontFamily: 'mokoto', color: accentColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome messages
              const Text(
                'Alright, welcome aboard!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
              ),
              const Text(
                'From now on you always know what event to go to',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 48.0),

              // Input Fields (using controllers and validation)
              _buildInputField('Name', _nameController, Icons.person),
              _buildInputField(
                  'Phone number', _mobileController, Icons.phone_android),
              _buildInputField('Email Address', _emailController, Icons.email,
                  validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                } else if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              }),
              _buildInputField('Password', _passwordController, Icons.lock,
                  obscureText: true, validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                return null;
              }),

              const SizedBox(height: 48.0),

              // Register Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: mainColor,
                  backgroundColor: accentColor,
                  minimumSize: const Size.fromHeight(64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final name = _nameController.text;
                    final mobile = _mobileController.text;

                    final uId =
                        await FirebaseAuthService().signUp(email, password);
                    FirestoreService().addUser(name, mobile, email, uId);
                  }
                },
                child: const Text('Register',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),

              const SizedBox(height: 16.0),

              // Login Link
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginPage.pageRoute);
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Already on of us? ',
                            style: TextStyle(color: textColor)),
                        TextSpan(
                            text: 'Login now',
                            style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build input fields
  Widget _buildInputField(
      String label, TextEditingController controller, IconData icon,
      {bool obscureText = false, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: textSecendaryColor),
            label:
                Text(label, style: const TextStyle(color: textSecendaryColor)),
            filled: true,
            fillColor: containerColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator, // Use the provided validator or a default one
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
