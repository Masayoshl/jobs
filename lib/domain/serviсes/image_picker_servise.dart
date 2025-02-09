import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobs/UI/theme/theme.dart';

class ImagePickerServiseError extends Error {
  final String message;
  ImagePickerServiseError(this.message);
}

class ImagePickerServise {
  final _imagePicker = ImagePicker();
  final _imageCropper = ImageCropper();

  String? _lastOriginalImagePath;
  String? _lastCroppedImagePath;

  String? get lastOriginalPath => _lastOriginalImagePath;
  String? get lastCroppedPath => _lastCroppedImagePath;

  Future<CroppedFile> getImageFromGallery() async {
    final imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      throw ImagePickerServiseError('Image not selected');
    }

    _lastOriginalImagePath = imageFile.path;
    final croppedFile = await _cropImage(imageFile.path);

    // Если пользователь отменил кадрирование, создаем CroppedFile из оригинального изображения
    if (croppedFile == null) {
      _lastCroppedImagePath = _lastOriginalImagePath;
      return CroppedFile(_lastOriginalImagePath!);
    }

    _lastCroppedImagePath = croppedFile.path;
    return croppedFile;
  }

  Future<CroppedFile> getImageFromCamera() async {
    final imageFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (imageFile == null) {
      throw ImagePickerServiseError('Image not selected');
    }

    _lastOriginalImagePath = imageFile.path;
    final croppedFile = await _cropImage(imageFile.path);

    if (croppedFile == null) {
      _lastCroppedImagePath = _lastOriginalImagePath;
      return CroppedFile(_lastOriginalImagePath!);
    }

    _lastCroppedImagePath = croppedFile.path;
    return croppedFile;
  }

  Future<CroppedFile> recropLastImage() async {
    if (_lastOriginalImagePath == null) {
      throw ImagePickerServiseError('No previous image available');
    }

    final croppedFile = await _cropImage(_lastOriginalImagePath!);
    if (croppedFile == null) {
      throw ImagePickerServiseError('Image cropping cancelled');
    }

    _lastCroppedImagePath = croppedFile.path;
    return croppedFile;
  }

  Future<CroppedFile?> _cropImage(String sourcePath) async {
    return await _imageCropper.cropImage(
      sourcePath: sourcePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          hideBottomControls: true,
          toolbarColor: primaryColor500,
          toolbarWidgetColor: Colors.white,
          backgroundColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );
  }
}
