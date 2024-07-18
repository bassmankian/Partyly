import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/models/providers/cart-provider.dart';
import 'package:provider/provider.dart'; // Assuming you have your color definitions here

class CounterWidget extends StatefulWidget {
  CounterWidget({required this.index, super.key});
  final int index;

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int quantity;
  late int _index;
  bool _isDeleting = false; // Flag to control the animation

  @override
  void initState() {
    super.initState();
    _index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final cartItems = cartProvider.items;
    quantity = cartItems[_index].quantity;

    return Container(
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
        children: [
          quantity == 0
              ? TextButton.icon(
                  onPressed: () {
                    cartProvider.removeTicket(cartItems[_index].ticket);
                  },
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'))
              : TextButton(
                  onPressed: () {
                    setState(() {
                      if (quantity > 0) {
                        setState(() {
                          cartProvider.updateTicketQuantity(
                              cartItems[_index].ticket,
                              --quantity,
                              cartItems[_index].event);
                        });
                      }
                    });
                  },
                  child: const Text(
                    '-',
                    style: TextStyle(
                        fontSize: 24, color: accentColor), // Increase font size
                  ),
                ),
          Text(
            '$quantity', // Display the quantity
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                cartProvider.updateTicketQuantity(cartItems[_index].ticket,
                    ++quantity, cartItems[_index].event);
              });
            },
            child: const Text(
              '+',
              style: TextStyle(
                  fontSize: 24, color: accentColor), // Increase font size
            ),
          ),
        ],
      ),
    );
  }
}
