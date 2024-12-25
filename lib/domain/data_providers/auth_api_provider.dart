import '../api_client/api_client.dart';

abstract class AuthApiProviderError {}

class AuthApiProviderIncorrectLoginDataError {}

class AuthApiProviderIncorrectEmailDataError {}

class AuthApiProviderIncorrectPasswordDataError {}

class AuthApiProvider {
  final _apiClient = ApiClient();
  Future<String> signIn(String email, String password) async {
    final isLogin = await _apiClient.auth(username: email, password: password);
    if (isLogin) {
      return 'Success!';
    } else {
      print('ERROR');
      throw AuthApiProviderIncorrectEmailDataError();
    }
  }

  Future<String> signUp(String email, String password, String name) async {
    //TODO

    final isLogin = await _apiClient.auth(username: name, password: password);
    if (isLogin) {
      return 'Success!';
    } else {
      print('ERROR');
      throw AuthApiProviderIncorrectEmailDataError();
    }
  }
}
