import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class Storeage {
  Future<String> uploadImageToFirebase(
      File imageFile, String category, String eventId) async {
    try {
      // Reference to the storage location (folder)
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('events/$category/posters/${eventId}_poster');

      // Upload the file
      firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);

      // Wait for the upload to complete
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL of the uploaded image
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error as needed (e.g., return an error message or null)
      return ''; // Or throw an exception
    }
  }

//   Future<String> getEventPosterUrl(String eventId) async {
//   try {
//     // Construct the path to the poster
//     String imagePath = 'events/${event.category}/$eventId/posters/${eventId}_poster.jpg';

//     // Get the download URL
//     String downloadURL = await firebase_storage.FirebaseStorage.instance
//         .ref(imagePath)
//         .getDownloadURL();
//     return downloadURL;
//   } catch (e) {
//     // Handle errors (e.g., image not found)
//   }
// }
}
