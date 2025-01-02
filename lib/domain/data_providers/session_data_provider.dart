abstract class SessionDataProviderKeys {
  static const _apiKey = 'api_key'; //? Ключ в SharedPreferences
}

abstract class SessionDataProviderError {}

class SessionDataProviderInvalidKeyError {}

class SessionDataProvider {
  // final _storage = FlutterSecureStorage();

  Future<String?> getApiKey() async {
    // final apiKey = await _storage.read(key: SessionDataProviderKeys._apiKey);
    // if (apiKey == null) {
    //   throw SessionDataProviderInvalidKeyError;
    // }
    // return apiKey;
  }

  Future<void> saveApiKey(String value) async {
    // await _storage.write(key: SessionDataProviderKeys._apiKey, value: value);
  }

  Future<void> deleteApiKey() async {
    // _storage.delete(key: SessionDataProviderKeys._apiKey);
  }
}
