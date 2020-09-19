import 'package:domain/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class AuthSDS {
  AuthSDS({
    @required this.secureStorage,
  }) : assert(secureStorage != null);

  final FlutterSecureStorage secureStorage;

  Future<void> upsertPassword(String username, String password) =>
      secureStorage.write(
        key: username,
        value: password,
      );

  Future<String> getPassword(String username) => secureStorage
      .read(
        key: username,
      )
      .catchError(
        (_) => throw NoUserCreatedException(),
      );

  Future<void> deletePassword(String username) => secureStorage.delete(
        key: username,
      );
}
