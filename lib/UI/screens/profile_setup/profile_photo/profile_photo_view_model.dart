// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:jobs/domain/servi%D1%81es/image_picker_servise.dart';

class ProfilePhotoState {
  String? errorMassage;
  String? file;
  ProfilePhotoState({
    this.errorMassage,
    this.file,
  });

  ProfilePhotoState copyWith({
    String? errorMassage,
    String? file,
  }) {
    return ProfilePhotoState(
      errorMassage: errorMassage ?? this.errorMassage,
      file: file ?? this.file,
    );
  }
}

class ProfilePhotoViewModel extends ChangeNotifier {
  final _imagePickerService = ImagePickerServise();
  ProfilePhotoState _state = ProfilePhotoState();
  ProfilePhotoState get state => _state;
  Future<void> onGalleryButtonPressed() async {
    try {
      final newFile = await _imagePickerService.getImageFromGallery();
      _state = state.copyWith(file: newFile.path);
      notifyListeners();
    } on ImagePickerServiseError catch (e) {
      _state = state.copyWith(errorMassage: e.message);
    } catch (e) {
      _state = state.copyWith(errorMassage: e.toString());
    } finally {
      debugPrint(_state.errorMassage);
    }
  }

  Future<void> onCameraButtonPressed() async {
    try {
      final newFile = await _imagePickerService.getImageFromCamera();
      _state = state.copyWith(file: newFile.path);
      notifyListeners();
    } on ImagePickerServiseError catch (e) {
      _state = state.copyWith(errorMassage: e.message);
    } catch (e) {
      _state = state.copyWith(errorMassage: e.toString());
    } finally {
      debugPrint(_state.errorMassage);
    }
  }
}
