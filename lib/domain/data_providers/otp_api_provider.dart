import 'package:jobs/domain/api_client/api_client.dart';

abstract class AuthApiProviderError {}

class OtpApiProviderIncorrectCodeDataError {}

class OtpApiProvider {
  final _apiClient = ApiClient();
  late String _otpCode;
  Future<String> getOtpCode() async {
    _otpCode = await _apiClient.getOTP();
    print(_otpCode);
    return _otpCode;
  }

  bool compareCode(String code) {
    if (code != _otpCode) {
      throw OtpApiProviderIncorrectCodeDataError();
    }
    return true;
  }
}
