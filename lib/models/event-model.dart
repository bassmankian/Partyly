class Event {
  final String eventId;
  final String name;
  final String category;
  final DateTime date;
  final DateTime? startTime; // Optional start time
  final DateTime? endTime; // Optional end time
  final Map<String, dynamic>? statistics; // Optional statistics
  final String organizerId;
  final Map<String, dynamic>? privateData; // Optional private data

  Event({
    required this.eventId,
    required this.name,
    required this.category,
    required this.date,
    this.startTime,
    this.endTime,
    this.statistics,
    required this.organizerId,
    this.privateData,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventId: json['eventId'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        date: DateTime.parse(json['date'] as String),
        startTime: json['startTime'] != null
            ? DateTime.parse(json['startTime'] as String)
            : null,
        endTime: json['endTime'] != null
            ? DateTime.parse(json['endTime'] as String)
            : null,
        statistics: json['statistics'] as Map<String, dynamic>?,
        organizerId: json['organizerId'] as String,
        privateData: json['privateData'] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'name': name,
        'category': category,
        'date': date.toIso8601String(),
        'startTime': startTime?.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
        'statistics': statistics,
        'organizerId': organizerId,
        'privateData': privateData,
      };
}
