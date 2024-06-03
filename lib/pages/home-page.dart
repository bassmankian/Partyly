import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/functions/firebase_auth.dart';
import 'package:partyly_app/widgets/category_bar.dart';
import 'package:partyly_app/widgets/event_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static const String pageRoute = '/homePage';

  final _authService = FirebaseAuthService();

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Main banner for asdvertisment
                Container(
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
                const SizedBox(
                  height: 30,
                ),

                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Poplar Categories',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const CategoryBar(),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Trending Parties Around You',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),

                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: EventCard(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: EventCard(),
                      ),
                      EventCard(),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     foregroundColor: mainColor,
                //     backgroundColor: accentColor,
                //     minimumSize: const Size.fromHeight(64),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(16.0),
                //     ),
                //   ),
                //   onPressed: () async {
                //     await _authService.signOut();
                //   },
                //   child: const Text('Log out',
                //       style:
                //           TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
