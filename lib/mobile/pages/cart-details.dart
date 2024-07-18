import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';
import 'package:partyly_app/models/providers/cart-provider.dart';
import 'package:partyly_app/widgets/counter.dart';
import 'package:partyly_app/widgets/ticket.dart';
import 'package:provider/provider.dart';

class CartDetailPage extends StatelessWidget {
  const CartDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final cartItems = cartProvider.items;
    int totalAmount = 0;
    for (var item in cartItems) {
      totalAmount += item.ticket.price * item.quantity;
    }

    return Scaffold(
      backgroundColor: mainColor,
      body: cartItems.isEmpty
          ? const Center(child: Text('Nothing to show'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'Your tickets',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        if (cartItems.isNotEmpty) {
                          return Column(
                            children: [
                              TicketCard(ticket: cartItems[index].ticket),
                              Container(
                                decoration: const BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Total:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          '${cartItems[index].quantity * cartItems[index].ticket.price} ₺',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          )),
                                      CounterWidget(index: index)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          );
                        } else {
                          return const Text('Cart is emty');
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Checkout price:',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('${totalAmount.toString()} ₺',
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
    );
  }
}
