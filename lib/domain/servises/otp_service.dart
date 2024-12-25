import 'package:jobs/domain/data_providers/otp_api_provider.dart';

class OtpService {
  final _otpApiProvider = OtpApiProvider();

  Future<String> getOtpCode() async {
    return await _otpApiProvider.getOtpCode();
  }

  Future<String> compareCode(String code) async {
    await Future.delayed(Duration(seconds: 1));
    if (_otpApiProvider.compareCode(code)) {
      return 'Sucsess';
    }
    return 'not equal';
  }
}
