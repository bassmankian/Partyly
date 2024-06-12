import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';

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
        trailing: Text('${price.toString()} + TRY'),
      ),
    );
  }
}

Icon getIcon(String value) {
  switch (value) {
    case 'Regular':
      return const Icon(Icons.star_border,
          color: accentColor); // Example Icon 1
    case 'VIP':
      return const Icon(Icons.star, color: accentColor); // Example Icon 2
    default:
      return const Icon(Icons.star_purple500_rounded,
          color: accentColor); // Default Icon
  }
}
