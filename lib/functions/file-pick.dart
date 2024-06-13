import 'dart:io'; // For working with files
import 'package:file_picker/file_picker.dart';

class PickFile {
  // PICK SINGLE IMAGE
  Future<File?> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Only allow image selection
        allowMultiple: false, // Only allow single file selection
      );

      if (result != null && result.files.isNotEmpty) {
        // Get the first selected file (since we only allow one)
        PlatformFile file = result.files.first;
        return File(file.path!); // Convert to File object
      } else {
        // User canceled the picker
        return null;
      }
    } catch (e) {
      print('Error picking image: $e');
      return null; // Or you can throw an exception
    }
  }

  // pick multiple images
  Future<List<File>> pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Only allow image selection
        allowMultiple: true, // Allow multiple files
      );

      if (result != null) {
        // Convert the selected files to a list of File objects
        List<File> files = result.paths.map((path) => File(path!)).toList();
        return files;
      } else {
        // User canceled the picker
        return []; // Return an empty list
      }
    } catch (e) {
      print('Error picking images: $e');
      return []; // Or throw an exception
    }
  }
}
