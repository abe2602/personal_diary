import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthSDS {
  AuthSDS({
    @required this.secureStorage,
  }) : assert(secureStorage != null);

  static const _passwordKey = '_passwordKey';

  final FlutterSecureStorage secureStorage;

  Future<void> upsertPassword(String accessToken) => secureStorage.write(
    key: _passwordKey,
    value: accessToken,
  );

  Future<String> getPassword() => secureStorage.read(
    key: _passwordKey,
  );

  Future<void> deletePassword() => secureStorage.delete(
    key: _passwordKey,
  );
}
