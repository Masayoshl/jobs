// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:jobs/UI/common/button_state.dart';
import 'package:jobs/UI/widgets/overlays/success_bottom_sheet.dart';
import 'package:jobs/domain/servi%D1%81es/image_picker_servise.dart';
import 'package:jobs/domain/servi%D1%81es/profile_service.dart';
import 'package:jobs/gen/assets.gen.dart';

class ProfilePhotoState {
  String? errorMassage;
  String? file;
  bool isCameraLoading;
  bool isGalleryLoading;
  bool isLoading;
  ProfilePhotoState({
    this.errorMassage,
    this.file,
    this.isCameraLoading = false,
    this.isGalleryLoading = false,
    this.isLoading = false,
  });
  ButtonState get cameraButtonState {
    if (isCameraLoading) return ButtonState.inProcess;
    return ButtonState.enabled;
  }

  ButtonState get galleryButtonState {
    if (isGalleryLoading) return ButtonState.inProcess;
    return ButtonState.enabled;
  }

  ButtonState get primaryButtonState {
    if (isLoading) return ButtonState.inProcess;
    return ButtonState.enabled;
  }

  ProfilePhotoState copyWith({
    String? errorMassage,
    String? file,
    bool? isCameraLoading,
    bool? isGalleryLoading,
    bool? isLoading,
  }) {
    return ProfilePhotoState(
      errorMassage: errorMassage ?? this.errorMassage,
      file: file ?? this.file,
      isCameraLoading: isCameraLoading ?? this.isCameraLoading,
      isGalleryLoading: isGalleryLoading ?? this.isGalleryLoading,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfilePhotoViewModel extends ChangeNotifier {
  final _profileService = ProfileService();
  final _imagePickerService = ImagePickerServise();
  ProfilePhotoState _state = ProfilePhotoState();
  ProfilePhotoState get state => _state;

  Future<void> onGalleryButtonPressed() async {
    _state = state.copyWith(isGalleryLoading: true);
    notifyListeners();
    try {
      final newFile = await _imagePickerService.getImageFromGallery();
      _state = state.copyWith(file: newFile.path);
      notifyListeners();
    } on ImagePickerServiseError catch (e) {
      _state = state.copyWith(errorMassage: e.message);
    } catch (e) {
      _state = state.copyWith(errorMassage: e.toString());
    } finally {
      _state = state.copyWith(isGalleryLoading: false);
      notifyListeners();
      debugPrint(_state.errorMassage);
    }
  }

  Future<void> onImagePressed() async {
    _state = state.copyWith(isCameraLoading: true, isGalleryLoading: true);
    notifyListeners();
    try {
      final newFile = await _imagePickerService.recropLastImage();
      _state = state.copyWith(file: newFile.path);
      notifyListeners();
    } on ImagePickerServiseError catch (e) {
      _state = state.copyWith(errorMassage: e.message);
    } catch (e) {
      _state = state.copyWith(errorMassage: e.toString());
    } finally {
      _state = state.copyWith(isCameraLoading: false, isGalleryLoading: false);
      notifyListeners();
      debugPrint(_state.errorMassage);
    }
  }

  Future<void> onCameraButtonPressed() async {
    _state = state.copyWith(isCameraLoading: true);
    notifyListeners();
    try {
      final newFile = await _imagePickerService.getImageFromCamera();
      _state = state.copyWith(file: newFile.path);
      notifyListeners();
    } on ImagePickerServiseError catch (e) {
      _state = state.copyWith(errorMassage: e.message);
    } catch (e) {
      _state = state.copyWith(errorMassage: e.toString());
    } finally {
      _state = state.copyWith(isCameraLoading: false);
      notifyListeners();
      debugPrint(_state.errorMassage);
    }
  }

  void navToHomePage(BuildContext context) {}
  Future<void> onPrimaryButtonPressed(BuildContext context) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    if (state.file == null) {
      final defaultFile = Assets.images.defaultProfileImage.path;
      _state = state.copyWith(file: defaultFile);
    }
    try {
      await _profileService.setAccountImage(_state.file!);
      SuccessBottomSheet.show(
        context: context,
        buttonText: 'Home Page',
        message: 'Your profile setup has been completed successfully',
        onPressedAction: (context) => navToHomePage(context),
      );
    } on ImagePickerServiseError catch (e) {
      _state = state.copyWith(errorMassage: e.message);
    } catch (e) {
      _state = state.copyWith(errorMassage: e.toString());
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
      debugPrint(_state.errorMassage);
    }
  }
}
