import 'package:jobs/domain/data_providers/profile_api_provider.dart';
import 'package:jobs/domain/data_providers/session_data_provider.dart';

class ProfileService {
  late final _sessionToken;
  final sessionDataProvider = SessionDataProvider();
  final profileApiProvider = ProfileApiProvider();
  ProfileService() {
    _getSessionToken();
  }

  Future<void> setAccountType() async {
    await Future.delayed(const Duration(seconds: 1));
    profileApiProvider.setAccountType(_sessionToken);
  }

  void _getSessionToken() async {
    sessionDataProvider.saveApiKey('66554433');
    //   _sessionToken = await SessionDataProvider().getApiKey();
  }
}
