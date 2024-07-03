import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/models/ticket-model.dart';

class TicketCard extends StatelessWidget {
  TicketCard({required this.ticket, super.key});

  final TicketShortInfo ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      color: containerColor,
      child: ListTile(
        subtitle: Text(ticket.description),
        leading: Container(
          decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Padding(
              padding: const EdgeInsets.all(16), child: getIcon(ticket.type)),
        ),
        title: Text(
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ticket.type),
        trailing: Text(
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            '${ticket.price.toString()} TRY'),
      ),
    );
  }
}

Icon getIcon(String value) {
  switch (value) {
    case 'Regular':
      return const Icon(
        Icons.star_border,
        color: accentColor,
      ); // Example Icon 1
    case 'VIP':
      return const Icon(Icons.star, color: accentColor); // Example Icon 2
    default:
      return const Icon(Icons.star_purple500_rounded,
          color: accentColor); // Default Icon
  }
}
