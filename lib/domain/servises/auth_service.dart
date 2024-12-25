import '../data_providers/auth_api_provider.dart';

class AuthService {
  late final String sessionId;
  final _authApiProvider = AuthApiProvider();

  Future<bool> isAuth() async {
    await Future.delayed(const Duration(seconds: 1));
    // ignore: prefer_const_declarations
    final isAuth = false;
    return isAuth;
  }

  Future<void> signIn(String email, String password) async {
    sessionId = await _authApiProvider.signIn(email, password);
    print(sessionId);
  }

  Future<void> signUp(String email, String password, String name) async {
    sessionId = await _authApiProvider.signUp(email, password, name);
    print(sessionId);
  }

  Future<void> forgotPassword(String email) async {
    //TODO
    await Future.delayed(const Duration(seconds: 1));

    print('Sucsess');
  }
}
