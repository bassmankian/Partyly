import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/mobile/pages/explore-page.dart';
import 'package:partyly_app/mobile/pages/home-page.dart';
import 'package:partyly_app/mobile/pages/me-page.dart';
import 'package:partyly_app/mobile/pages/reservation-page.dart';
import 'package:partyly_app/models/event-model.dart';
import 'package:partyly_app/widgets/event_card.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int myIndex = 0;
  List screenWidgets = [
    HomePage(),
    const ExplorePage(),
    const ReservationPage(),
    const MePage()
  ];

  void onIndexChanged(int newIndex) {
    // Callback function
    setState(() {
      myIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          // centerTitle: true,
          title: Image.asset(
            'assets/logo/Partyly - Logo (trans).png',
            height: 68,
            // fit: BoxFit.cover,
          ),
        ),
        body: screenWidgets[myIndex],
        bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: myIndex,
          onIndexChanged: onIndexChanged,
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  int currentIndex = 0;
  Function onIndexChanged;
  MyBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onIndexChanged});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
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

              currentIndex: widget
                  .currentIndex, // Set to the initial selected index (e.g., 0 for Home)
              onTap: (index) {
                widget.onIndexChanged(index);
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

FutureBuilder<List<Event>> eventCardCaroucel(Function future) {
  return FutureBuilder<List<Event>>(
    future: future(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Text('Error fetching events');
      } else if (snapshot.hasData) {
        final events = snapshot.data!;
        return SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection:
                Axis.horizontal, // Assuming you want horizontal scrolling
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: EventCard(event: events[index]),
              );
            },
            shrinkWrap: true, // Allow ListView to shrink to fit content
          ),
        );
      } else {
        return const Text('No events found');
      }
    },
  );
}
