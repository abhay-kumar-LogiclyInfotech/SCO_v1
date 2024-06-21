import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaServices {
  MediaServices();

  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> getImageFromGallery() async {
    final XFile? file =
        // await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    await _imagePicker.pickImage(source: ImageSource.gallery);


    if (file != null) {
      print("---------printing the path of the file: ${file.path.toString()}");
      return File(file.path);
    } else {

      print("----------No image selected");

      return null;
    }
  }
}
