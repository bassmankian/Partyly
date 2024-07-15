import 'package:flutter/material.dart';
import 'package:partyly_app/models/providers/cart-provider.dart';
import 'package:provider/provider.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Center(child: Text('Items in the cart are:' + cartItems.toString()));
  }
}
