// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ticket {
  final String ticketId;
  final String eventId;
  final String userId;
  final double price;
  final String status;
  final DateTime datePurchased;
  final int quantity;
  final String? ticketType; // Optional ticket type
  Ticket({
    required this.ticketId,
    required this.eventId,
    required this.userId,
    required this.price,
    required this.status,
    required this.datePurchased,
    required this.quantity,
    this.ticketType,
  });

  Ticket copyWith({
    String? ticketId,
    String? eventId,
    String? userId,
    double? price,
    String? status,
    DateTime? datePurchased,
    int? quantity,
    String? ticketType,
  }) {
    return Ticket(
      ticketId: ticketId ?? this.ticketId,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      price: price ?? this.price,
      status: status ?? this.status,
      datePurchased: datePurchased ?? this.datePurchased,
      quantity: quantity ?? this.quantity,
      ticketType: ticketType ?? this.ticketType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ticketId': ticketId,
      'eventId': eventId,
      'userId': userId,
      'price': price,
      'status': status,
      'datePurchased': datePurchased.millisecondsSinceEpoch,
      'quantity': quantity,
      'ticketType': ticketType,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      ticketId: map['ticketId'] as String,
      eventId: map['eventId'] as String,
      userId: map['userId'] as String,
      price: map['price'] as double,
      status: map['status'] as String,
      datePurchased:
          DateTime.fromMillisecondsSinceEpoch(map['datePurchased'] as int),
      quantity: map['quantity'] as int,
      ticketType:
          map['ticketType'] != null ? map['ticketType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) =>
      Ticket.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ticket(ticketId: $ticketId, eventId: $eventId, userId: $userId, price: $price, status: $status, datePurchased: $datePurchased, quantity: $quantity, ticketType: $ticketType)';
  }

  @override
  bool operator ==(covariant Ticket other) {
    if (identical(this, other)) return true;

    return other.ticketId == ticketId &&
        other.eventId == eventId &&
        other.userId == userId &&
        other.price == price &&
        other.status == status &&
        other.datePurchased == datePurchased &&
        other.quantity == quantity &&
        other.ticketType == ticketType;
  }
}

class TicketShortInfo {
  final int price;
  final String type;
  TicketShortInfo({
    required this.price,
    required this.type,
  });

  TicketShortInfo copyWith({
    int? price,
    String? type,
  }) {
    return TicketShortInfo(
      price: price ?? this.price,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'type': type,
    };
  }

  factory TicketShortInfo.fromJson(Map<String, dynamic> map) {
    return TicketShortInfo(
      price: map['price'] as int,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'ClassName(price: $price, type: $type)';

  @override
  bool operator ==(covariant TicketShortInfo other) {
    if (identical(this, other)) return true;

    return other.price == price && other.type == type;
  }

  @override
  int get hashCode => price.hashCode ^ type.hashCode;
}
