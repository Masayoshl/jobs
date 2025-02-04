import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isInitialized = false;
  bool _isListening = false;

  final StreamController<String> _textStreamController =
      StreamController<String>.broadcast();
  Stream<String> get textStream => _textStreamController.stream;

  final StreamController<bool> _isListeningStreamController =
      StreamController<bool>.broadcast();
  Stream<bool> get isListeningStream => _isListeningStreamController.stream;

  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      _isInitialized = await _speech.initialize(
        onError: (errorNotification) {
          print('Speech recognition error: ${errorNotification.errorMsg}');
          if (errorNotification.permanent) {
            _isInitialized = false;
          }
          _updateListeningState(false);
        },
        onStatus: (status) {
          print('Speech recognition status: $status');
          if (status == 'done' || status == 'notListening') {
            _updateListeningState(false);
          } else if (status == 'listening') {
            _updateListeningState(true);
          }
        },
        finalTimeout: const Duration(milliseconds: 2000),
        debugLogging: true,
      );

      final hasPermission = await _speech.hasPermission;
      if (!hasPermission) {
        print('Speech recognition permission denied');
        _isInitialized = false;
        return false;
      }

      return _isInitialized;
    } catch (e) {
      print('Speech recognition initialization error: $e');
      _isInitialized = false;
      return false;
    }
  }

  void _updateListeningState(bool listening) {
    if (_isListening != listening) {
      _isListening = listening;
      _isListeningStreamController.add(_isListening);
    }
  }

  Future<void> startListening({String? selectedLocaleId}) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) {
        print('Failed to initialize speech recognition');
        throw Exception('Speech recognition failed to initialize');
      }
    }

    await _speech.listen(
      onResult: (result) {
        print('Speech result received: ${result.recognizedWords}');
        print('Is final result: ${result.finalResult}');

        if (result.finalResult) {
          print('Sending final result to stream: ${result.recognizedWords}');
          _textStreamController.add(result.recognizedWords);
          _updateListeningState(false);
        }
      },
      localeId: selectedLocaleId,
      listenMode: stt.ListenMode.confirmation,
      cancelOnError: true,
      partialResults: false,
    );

    print('Started listening');
    _updateListeningState(true);
  }

  Future<void> stopListening() async {
    await _speech.stop();
    _updateListeningState(false);
  }

  Future<void> cancelListening() async {
    await _speech.cancel();
    _updateListeningState(false);
  }

  Future<List<stt.LocaleName>> getAvailableLocales() async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) {
        throw Exception('Speech recognition failed to initialize');
      }
    }
    return await _speech.locales();
  }

  bool get isAvailable => _speech.isAvailable;

  bool get isListening => _isListening;

  void dispose() {
    _textStreamController.close();
    _isListeningStreamController.close();
  }
}
