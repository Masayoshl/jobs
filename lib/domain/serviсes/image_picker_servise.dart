import 'package:image_picker/image_picker.dart';

class ImagePickerServiseError extends Error {
  final String message;
  ImagePickerServiseError(this.message);
}

class ImagePickerServise {
  Future<XFile> getImageFromCamera() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile == null) {
      throw ImagePickerServiseError('Something went wrong');
    }
    return imageFile;
  }

  Future<XFile> getImageFromGallery() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      throw ImagePickerServiseError('Something went wrong');
    }
    return imageFile;
  }
}
