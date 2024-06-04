import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
// Assuming mainColor and accentColor are defined elsewhere

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        // Clip the content to the rounded corners
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 30.0, sigmaY: 30.0), // Adjust blur intensity
            child: BottomNavigationBar(
              elevation: 0, // Remove the default shadow
              backgroundColor:
                  mainColor.withOpacity(0.5), // Set desired opacity

              currentIndex:
                  0, // Set to the initial selected index (e.g., 0 for Home)
              onTap: (index) {
                if (index == 0) {
                  // Navigate to home page
                } else if (index == 1) {
                  // Navigate to explore page
                } // ... and so on
              },
              selectedItemColor:
                  accentColor, // Color of the selected item (e.g., yellow)
              unselectedItemColor: Colors.white,
              showUnselectedLabels: true, // Show labels even when not selected
              type:
                  BottomNavigationBarType.fixed, // Fixed style with four items
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event_note), // Reservation icon
                  label: 'Reservation',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Me',
                ),
              ],
            )));
  }
}
