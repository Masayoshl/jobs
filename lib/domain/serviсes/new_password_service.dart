class NewPasswordService {
  Future<String> changePassword(String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (password.contains(RegExp(r'Z', caseSensitive: false))) {
      throw ArgumentError('Something went wrong');
    }
    return 'Success';
  }
}
