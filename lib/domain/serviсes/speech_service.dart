import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isInitialized = false;

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
        },
        onStatus: (status) {
          print('Speech recognition status: $status');
          if (status == 'done') {
            _isListeningStreamController.add(false);
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

  Future<void> startListening({String? selectedLocaleId}) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) {
        throw Exception('Speech recognition failed to initialize');
      }
    }

    await _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          _textStreamController.add(result.recognizedWords);
        }
      },
      localeId: selectedLocaleId,
      listenMode: stt.ListenMode.confirmation,
      cancelOnError: true,
      partialResults: false,
    );

    _isListeningStreamController.add(true);
  }

  // Остановка прослушивания
  Future<void> stopListening() async {
    await _speech.stop();
    _isListeningStreamController.add(false);
  }

  // Отмена прослушивания
  Future<void> cancelListening() async {
    await _speech.cancel();
    _isListeningStreamController.add(false);
  }

  // Получение списка доступных языков
  Future<List<stt.LocaleName>> getAvailableLocales() async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) {
        throw Exception('Speech recognition failed to initialize');
      }
    }
    return await _speech.locales();
  }

  // Проверка, доступно ли распознавание речи
  bool get isAvailable => _speech.isAvailable;

  // Проверка, идет ли прослушивание
  bool get isListening => _speech.isListening;

  // Освобождение ресурсов
  void dispose() {
    _textStreamController.close();
    _isListeningStreamController.close();
  }
}
