import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/functions/firebase-firestore.dart';
import 'package:partyly_app/models/ticket-model.dart';

class TicketCard extends StatelessWidget {
  TicketCard({required this.type, required this.price, super.key});

  final String type;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: containerColor,
      child: ListTile(
        title: Text(type),
        leading: Text(price.toString()),
      ),
    );
  }
}
