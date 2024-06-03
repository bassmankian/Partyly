import 'package:firebase_auth/firebase_auth.dart';
import 'package:partyly_app/common/utilities.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Success - Navigate to the next screen or perform other actions
      // You can remove the SnackBarHelper.showSnackBar('it works'); if not needed
      return credential;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      print('the error is: ${e.message}');

      SnackBarHelper.showSnackBar(e.message.toString());
      return null; // Indicate failure
    } catch (e) {
      // Handle other unexpected errors
      SnackBarHelper.showSnackBar('An unexpected error occurred.');
      return null; // Indicate failure
    }
  }

// Sign up with email and password

  // Sign up with email and password
  Future<String> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user?.uid; // Get the UID from the UserCredential
      if (uid != null) {
        return uid; // Return the UID
      } else {
        throw FirebaseAuthException(
            code: 'ERROR_NO_UID', message: 'Failed to get UID after sign-up.');
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      SnackBarHelper.showSnackBar(e.message!);

      throw e; // Re-throw the FirebaseAuthException to propagate the error
    } catch (e) {
      print('General Exception: $e');
      rethrow; // Re-throw any other exceptions to propagate the error
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get the currently signed-in user (if any)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Check if a user is currently signed in
  bool isSignedIn() {
    final user = _auth.currentUser;
    return user != null;
  }

  // Get the current user object (if signed in)
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get the UID of the current user (if signed in)
  String? getCurrentUserId() {
    final user = _auth.currentUser;
    return user?.uid;
  }

  // Reset password for a user with a specific email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      rethrow;
    }
  }
}
