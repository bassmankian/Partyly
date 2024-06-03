import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String name;
  final String category;
  final Timestamp startDate;
  final Timestamp endDate;
  final Timestamp startTime;
  final Timestamp endTime;
  final String? thumbnailUrl;
  final List<String>? imageUrls;
  final String organizerId;

  Event({
    required this.name,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.thumbnailUrl,
    this.imageUrls,
    required this.organizerId,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        name: json['name'] as String,
        category: json['category'] as String,
        // Directly access Timestamp objects from Firestore
        startDate: json['startDate'] as Timestamp,
        endDate: json['endDate'] as Timestamp,
        startTime: json['startTime'] as Timestamp, // Handle optional time
        endTime: json['endTime'] as Timestamp, // Handle optional time
        thumbnailUrl: json['thumbnailUrl'] as String?,
        imageUrls: json['imageUrls']?.cast<String>(),
        organizerId: json['organizerId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        // Store Timestamps directly
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime,
        'thumbnailUrl': thumbnailUrl,
        'imageUrls': imageUrls,
        'organizerId': organizerId,
      };
}
