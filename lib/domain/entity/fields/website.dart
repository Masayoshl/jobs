import 'package:jobs/domain/entity/fields/validoation_result.dart';

class Website {
  final String value;
  final String? errorMessage;
  final bool hasError;
  final bool isDirty;

  // Регулярное выражение для проверки URL
  // Поддерживает:
  // - HTTP и HTTPS протоколы
  // - Поддомены
  // - Порты
  // - Пути
  // - Параметры запроса
  // - Якоря
  static const String _urlRegexPattern = r'^(https?:\/\/)?' // протокол
      r'((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|' // доменное имя
      r'((\d{1,3}\.){3}\d{1,3}))' // IP адрес
      r'(\:\d+)?' // порт
      r'(\/[-a-z\d%_.~+]*)*' // путь
      r'(\?[;&a-z\d%_.~+=-]*)?' // параметры запроса
      r'(\#[-a-z\d_]*)?$'; // якорь

  const Website._({
    required this.value,
    this.errorMessage,
    this.hasError = false,
    this.isDirty = false,
  });

  factory Website({
    String value = '',
    bool isDirty = false,
    String? externalErrorMessage,
  }) {
    if (externalErrorMessage != null) {
      return Website._(
        value: value.trim(),
        errorMessage: externalErrorMessage,
        hasError: true,
        isDirty: true,
      );
    }

    final validationResult = Website._validate(value);

    return Website._(
      value: value.trim(),
      errorMessage: isDirty ? validationResult.errorMessage : null,
      hasError: isDirty ? !validationResult.isValid : false,
      isDirty: isDirty,
    );
  }

  static ValidationResult _validate(String value) {
    if (value.isEmpty) {
      return const ValidationResult.invalid('URL cannot be empty');
    }

    final urlRegex = RegExp(_urlRegexPattern, caseSensitive: false);
    if (!urlRegex.hasMatch(value)) {
      return const ValidationResult.invalid('Invalid URL format');
    }

    // Дополнительные проверки
    try {
      final uri = Uri.parse(value);
      if (!uri.hasScheme && !value.startsWith('http')) {
        // Если схема не указана, предполагаем http
        value = 'http://$value';
      }
    } catch (e) {
      return const ValidationResult.invalid('Invalid URL format');
    }

    return const ValidationResult.valid();
  }

  String get normalizedUrl {
    if (value.isEmpty) return value;
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    return 'http://$value';
  }

  Website copyWith({String? value}) {
    if (value == null) return this;
    return Website(
      value: value,
      isDirty: true,
    );
  }

  bool get isValid => !hasError;

  @override
  String toString() =>
      'URL(value: $value, isValid: $isValid, error: $errorMessage, isDirty: $isDirty)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Website &&
        other.value == value &&
        other.errorMessage == errorMessage &&
        other.hasError == hasError &&
        other.isDirty == isDirty;
  }

  @override
  int get hashCode =>
      value.hashCode ^
      errorMessage.hashCode ^
      hasError.hashCode ^
      isDirty.hashCode;
}
