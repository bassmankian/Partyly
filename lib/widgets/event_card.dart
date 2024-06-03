import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: containerColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder image
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey, // Placeholder background
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.calendar_today, color: accentColor, size: 8),
              Text("Fri, 20 May 18:00",
                  style: TextStyle(color: accentColor, fontSize: 8)),
              SizedBox(width: 4),
              Icon(Icons.location_on, color: accentColor, size: 8),
              Text("Cheeta club, Kyrenia",
                  style: TextStyle(color: accentColor, fontSize: 8)),
            ],
          ),
          const SizedBox(height: 10),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Marshmello in Nicosia playing at Bariccade",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),

          const SizedBox(height: 10),

          const Row(
            children: [
              Icon(Icons.whatshot, color: Color(0xFFF25252)),
              SizedBox(width: 8),
              Text("NCY Events", style: TextStyle(color: Color(0xFFF25252))),
            ],
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 28,
            child: Row(
              children: [
                // Get ticket button
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: mainColor,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text("Get Tickets"),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                // like and heart button
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 28,
                    padding: const EdgeInsets.all(
                        4), // Add some padding for visual appeal
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Transparent background
                      borderRadius: BorderRadius.circular(4), // Rounded corners
                      border: Border.all(
                        color: const Color(0xFFF2C94C), // Gold border
                        width: 2.0, // Border width
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite_border, // Toggle icon
                      color: Color(0xFFF2C94C), // Gold color
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
