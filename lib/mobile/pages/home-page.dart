import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/functions/firebase-firestore.dart';
import 'package:partyly_app/functions/firebase_auth.dart';
import 'package:partyly_app/models/event-model.dart';
import 'package:partyly_app/widgets/category_bar.dart';
import 'package:partyly_app/widgets/event_card.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static const String pageRoute = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authService = FirebaseAuthService();

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchEvents();
  // }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Main banner for asdvertisment
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                      color: accentColor,
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(16))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Partyly',
                              style: TextStyle(
                                fontFamily: 'mokoto',
                                color: containerColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Get special discouts on \n your first ticket purchase',
                              style: TextStyle(
                                color: containerColor,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(12),
                                foregroundColor: accentColor,
                                backgroundColor: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              onPressed: () async {
                                await _authService.signOut();
                              },
                              child: const Text('GET YOUR FIRST TICKET',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Poplar Categories',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CategoryBar(),
              ),

              const SizedBox(
                height: 32,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Trending Parties Around You',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),

              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: EventCardCaroucel(FirestoreService().getAllEvents),
              ),

              const SizedBox(
                height: 32,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Upcoming events in the future',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),

              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: EventCardCaroucel(FirestoreService().getUpcomingEvents),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<Event>> EventCardCaroucel(Function future) {
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
                return EventCard(event: events[index]);
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
}
