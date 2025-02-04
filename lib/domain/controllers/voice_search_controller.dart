import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobs/domain/serviсes/speech_service.dart';

class VoiceSearchController {
  final SpeechService _speechService = SpeechService();
  StreamSubscription? _speechSubscription;
  StreamSubscription? _listeningStatusSubscription;
  bool _isListening = false;
  String? _errorMessage;
  final TextEditingController searchController;
  final void Function() onStateChanged;
  final void Function(String) onSearchQueryChanged;

  bool get isListening => _isListening;
  String? get errorMessage => _errorMessage;

  VoiceSearchController({
    required this.searchController,
    required this.onSearchQueryChanged,
    required this.onStateChanged,
  }) {
    _initializeSpeechService();
  }

  Future<void> _initializeSpeechService() async {
    print('Initializing speech service');
    await _speechService.initialize();

    _speechSubscription = _speechService.textStream.listen((text) {
      print('Received text in controller: $text');
      searchController.text = text;
      onSearchQueryChanged(text);
    });

    _listeningStatusSubscription =
        _speechService.isListeningStream.listen((isListening) {
      print('Listening status changed: $isListening');
      _isListening = isListening;
      onStateChanged();
    });
  }

  Future<void> toggleListening() async {
    try {
      if (_isListening) {
        await _speechService.stopListening();
      } else {
        await _speechService.startListening();
      }
    } catch (e) {
      _errorMessage =
          'Speech recognition is not available on this device. Please check your permissions and try again.';
      _isListening = false;
      onStateChanged();
      debugPrint('Speech recognition error: $e');
    }
  }

  void dispose() {
    _speechSubscription?.cancel();
    _listeningStatusSubscription?.cancel();
    _speechService.dispose();
  }
}
