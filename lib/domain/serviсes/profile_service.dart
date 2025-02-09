import 'package:jobs/domain/data_providers/account_type_data_provider.dart';
import 'package:jobs/domain/data_providers/profile_api_provider.dart';
import 'package:jobs/domain/data_providers/session_data_provider.dart';

class ProfileServiceError extends Error {
  final String message;
  ProfileServiceError(this.message);
}

class ProfileService {
  final _profileApiProvider = ProfileApiProvider();
  final _sessionDataProvider = SessionDataProvider();
  final _accountTypeDataProvider = AccountTypeDataProvider();

  String? _accountType;
  String get accountType => _accountType ?? '';

  String? _sessionToken;

  Future<void> initialize() async {
    _accountType = await _accountTypeDataProvider.getAccountType();
  }

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

  Future<void> setAccountType(String value) async {
    await _accountTypeDataProvider.saveAccountType(value);
    print(value);
    final token = await sessionToken;
    await _profileApiProvider.setAccountType(token);
  }

  Future<void> setAccountCountry() async {
    _sessionDataProvider.saveApiKey('665523');
    final token = await sessionToken;
    await _profileApiProvider.setAccountCountry(token);
  }

  Future<void> setAccountInfo() async {
    _sessionDataProvider.saveApiKey('665523');
    final token = await sessionToken;
    await _profileApiProvider.setAccountInfo(token);
  }

  Future<void> setAccountImage(String path) async {
    _sessionDataProvider.saveApiKey('665523');
    final token = await sessionToken;
    await _profileApiProvider.setAccountImage(token, path);
  }
}
