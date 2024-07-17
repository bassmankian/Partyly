import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:partyly_app/models/event-model.dart';
import 'package:partyly_app/models/ticket-model.dart'; // Assuming you have a Ticket model

class CartProvider with ChangeNotifier {
  final List<TicketItem> _items = [];

  // Getter for cart items
  List<TicketItem> get items => _items;

  // Add a ticket to the cart
  void addTicket(TicketShortInfo ticket, int quantity, Event event) {
    final existingItem = _items.firstWhereOrNull(
      (item) =>
          item.ticket.ticketId == ticket.ticketId, // Check for ticketId match
    );

    if (existingItem != null) {
      updateTicketQuantity(ticket, quantity, event); // Update if found
    } else {
      _items.add(TicketItem(
          ticket: ticket, quantity: quantity, event: event)); // Add new item
    }

    notifyListeners();
  }

  // Remove a ticket from the cart
  void removeTicket(TicketShortInfo ticket) {
    _items.removeWhere((item) => item.ticket.ticketId == ticket.ticketId);
    notifyListeners();
  }

  // Update the quantity of a ticket in the cart
  void updateTicketQuantity(TicketShortInfo ticket, int quantity, Event event) {
    final index =
        _items.indexWhere((item) => item.ticket.ticketId == ticket.ticketId);
    if (index != -1) {
      _items[index] =
          TicketItem(ticket: ticket, quantity: quantity, event: event);
      notifyListeners();
    }
  }

  // Clear the cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

// Helper class to hold ticket information and quantity
class TicketItem {
  final TicketShortInfo ticket;
  final Event event;
  int quantity;

  TicketItem(
      {required this.ticket, required this.quantity, required this.event});
}
