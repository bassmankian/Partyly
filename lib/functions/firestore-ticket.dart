import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyly_app/models/ticket-model.dart';

class FirestoreTicekts {
  // get event ticket info
  Future<List<TicketShortInfo>> getEventTicketInfo(String docId) async {
    try {
      final eventsCollection = FirebaseFirestore.instance.collection('events');
      final querySnapshot =
          await eventsCollection.doc(docId).collection('tickets').get();

      final ticketsInfos = querySnapshot.docs.map((doc) {
        final ticket = doc.data();
        return TicketShortInfo.fromJson(ticket); // Corrected type
      }).toList();

      return ticketsInfos; // Add return statement here
    } catch (error) {
      return [];
    }
  }
}
