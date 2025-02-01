import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/domain/servi%D1%81es/speech_service.dart';
import 'package:jobs/gen/assets.gen.dart';

class VoiceSearchController extends ChangeNotifier {
  final SpeechService _speechService = SpeechService();
  StreamSubscription? _speechSubscription;
  StreamSubscription? _listeningStatusSubscription;
  bool _isListening = false;
  String? _errorMessage;
  final TextEditingController searchController;
  final void Function(String) onSearchQueryChanged;

  bool get isListening => _isListening;
  String? get errorMessage => _errorMessage;

  VoiceSearchController({
    required this.searchController,
    required this.onSearchQueryChanged,
  }) {
    _initializeSpeechService();
  }

  Future<void> _initializeSpeechService() async {
    await _speechService.initialize();

    _speechSubscription = _speechService.textStream.listen((text) {
      searchController.text = text;
      onSearchQueryChanged(text);
    });

    _listeningStatusSubscription =
        _speechService.isListeningStream.listen((isListening) {
      _isListening = isListening;
      notifyListeners();
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
      notifyListeners();
      debugPrint('Speech recognition error: $e');
    }
  }

  @override
  void dispose() {
    _speechSubscription?.cancel();
    _listeningStatusSubscription?.cancel();
    _speechService.dispose();
    super.dispose();
  }
}

class SearchByVoiceField extends StatefulWidget {
  final void Function(String) onSearchQueryChanged;
  final TextEditingController searchController;

  const SearchByVoiceField({
    super.key,
    required this.onSearchQueryChanged,
    required this.searchController,
  });

  @override
  State<SearchByVoiceField> createState() => _SearchByVoiceFieldState();
}

class _SearchByVoiceFieldState extends State<SearchByVoiceField> {
  late final VoiceSearchController _voiceController;

  @override
  void initState() {
    super.initState();
    _voiceController = VoiceSearchController(
      searchController: widget.searchController,
      onSearchQueryChanged: widget.onSearchQueryChanged,
    );
  }

  @override
  void dispose() {
    _voiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _voiceController,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchBar(
            controller: widget.searchController,
            hintText: 'Search',
            hintStyle: WidgetStatePropertyAll(
                AppTextStyles.textXLRegular.copyWith(color: grayColor25)),
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            leading: SvgPicture.asset(
              Assets.icons.searchIcon,
              fit: BoxFit.none,
            ),
            shadowColor: const WidgetStatePropertyAll(Colors.black),
            elevation: const WidgetStatePropertyAll(2.0),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
            trailing: <Widget>[
              Tooltip(
                message: 'Search by voice',
                child: VoiceButtonWidget(
                  isListening: _voiceController.isListening,
                  onPressed: _voiceController.toggleListening,
                ),
              )
            ],
            onChanged: widget.onSearchQueryChanged,
          ),
        );
      },
    );
  }
}

class VoiceButtonWidget extends StatelessWidget {
  final bool isListening;
  final VoidCallback onPressed;

  const VoiceButtonWidget({
    super.key,
    required this.isListening,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      isSelected: isListening,
      icon: SvgPicture.asset(
        fit: BoxFit.none,
        Assets.icons.microphoneIcon,
        colorFilter: const ColorFilter.mode(
          primaryColor500,
          BlendMode.srcIn,
        ),
      ),
      selectedIcon: const Icon(
        color: errorColor500,
        Icons.stop_circle_rounded,
        size: 32,
      ),
    );
  }
}
