import 'package:flutter/foundation.dart';
import 'package:partyly_app/models/user-model.dart';

class UserProvider with ChangeNotifier {
  User? _user; // Store the User object

  User? get user => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
