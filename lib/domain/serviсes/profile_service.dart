import 'package:jobs/domain/data_providers/profile_api_provider.dart';
import 'package:jobs/domain/data_providers/session_data_provider.dart';

class ProfileService {
  late final _sessionToken;
  final _sessionDataProvider = SessionDataProvider();
  final _profileApiProvider = ProfileApiProvider();

  Future<bool> checkAuth() async {
    final apiKey = await _sessionDataProvider.getApiKey();
    return apiKey != null;
  }

  Future<void> setAccountType() async {
    await Future.delayed(const Duration(seconds: 1));
    _profileApiProvider.setAccountType(_sessionToken);
  }
}
