import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/functions/firebase_auth.dart';
import 'package:partyly_app/functions/firestore-event.dart';
import 'package:partyly_app/mobile/pages/main-scaffold.dart';
import 'package:partyly_app/widgets/category_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static const String pageRoute = '/homePage';

  final _authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
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
                                    fontWeight: FontWeight.bold, fontSize: 12)),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
            ),

            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: eventCardCaroucel(FirestoreEvents().getAllEvents),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
            ),

            const SizedBox(
              height: 16,
            ),
            eventCardCaroucel(FirestoreEvents().getUpcomingEvents),
          ],
        ),
      ),
    );
  }
}
