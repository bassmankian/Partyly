import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/models/providers/cart-provider.dart';
import 'package:provider/provider.dart';

class CartDetailPage extends StatelessWidget {
  const CartDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      backgroundColor: containerColor,
      body: Center(
          child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                trailing: Text(cartItems[index].quantity.toString()),
                leading: Text(cartItems[index].ticket.type),
                title: Text(cartItems[index].event.name),
                subtitle: Text(cartItems[index].ticket.price.toString()),
              ),
            );
          },
        ),
      )),
    );
  }
}
