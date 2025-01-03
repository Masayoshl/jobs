import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SessionDataProviderKeys {
  static const _apiKey = 'api_key';
}

abstract class SessionDataProviderError {}

class SessionDataProviderInvalidKeyError extends Error {
  final String message;
  SessionDataProviderInvalidKeyError([this.message = 'Invalid key']);
}

class SessionDataProvider {
  final _storage = FlutterSecureStorage();

  Future<String?> getApiKey() async {
    final apiKey = await _storage.read(key: SessionDataProviderKeys._apiKey);
    if (apiKey == null) {
      throw SessionDataProviderInvalidKeyError();
    } else {
      return apiKey;
    }
  }

  Future<void> saveApiKey(String value) async {
    await _storage.write(key: SessionDataProviderKeys._apiKey, value: value);
  }

  Future<void> deleteApiKey() async {
    _storage.delete(key: SessionDataProviderKeys._apiKey);
  }
}
