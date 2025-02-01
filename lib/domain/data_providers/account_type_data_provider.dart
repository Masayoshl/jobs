import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AccountTypeDataProviderKeys {
  static const _accountType = 'account_type';
}

class AccountTypeDataProviderAbsentTypeError extends Error {
  final String message;
  AccountTypeDataProviderAbsentTypeError(
      [this.message = 'Account type is missing']);
}

class AccountTypeDataProvider {
  final _storage = const FlutterSecureStorage();

  Future<String> getAccountType() async {
    final accountType =
        await _storage.read(key: AccountTypeDataProviderKeys._accountType);
    if (accountType == null) {
      throw AccountTypeDataProviderAbsentTypeError();
    }
    return accountType;
  }

  Future<void> saveAccountType(String value) async {
    await _storage.write(
        key: AccountTypeDataProviderKeys._accountType, value: value);
  }

  Future<void> deletAccountType() async {
    _storage.delete(key: AccountTypeDataProviderKeys._accountType);
  }
}
