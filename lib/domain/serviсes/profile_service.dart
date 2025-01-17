import 'package:jobs/domain/data_providers/profile_api_provider.dart';
import 'package:jobs/domain/data_providers/session_data_provider.dart';

class ProfileServiceError extends Error {
  final String message;
  ProfileServiceError(this.message);
}

class ProfileService {
  final _profileApiProvider = ProfileApiProvider();
  final _sessionDataProvider = SessionDataProvider();
  String? _sessionToken;

  Future<String> get sessionToken async {
    if (_sessionToken == null) {
      try {
        _sessionToken = await _sessionDataProvider.getApiKey();
      } on SessionDataProviderInvalidKeyError {
        throw ProfileServiceError('Session token not found');
      }
    }
    return _sessionToken!;
  }

  Future<void> setAccountType() async {
    final token = await sessionToken;
    await _profileApiProvider.setAccountType(token);
  }

  Future<void> setAccountCountry() async {
    _sessionDataProvider.saveApiKey('665523');
    final token = await sessionToken;
    await _profileApiProvider.setAccountType(token);
  }
}
