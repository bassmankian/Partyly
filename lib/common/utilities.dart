import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:partyly_app/common/app_colors.dart';

class SnackBarHelper {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: containerColor,
        content: Text(
          message,
          style: const TextStyle(color: textColor),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Access this in the MaterialApp's scaffoldMessengerKey property
  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;
}
