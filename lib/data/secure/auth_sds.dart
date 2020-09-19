import 'package:domain/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class AuthSDS {
  AuthSDS({
    @required this.secureStorage,
  }) : assert(secureStorage != null);

  final FlutterSecureStorage secureStorage;

  static const _userKey = 'userKey';

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

  Future<Box> _openUserBox() => Hive.openBox(_userKey);

  Future<String> getUserName() => _openUserBox().then(
        (box) {
          final userName = box.get(_userKey);

          if (userName == null) {
            throw NoUserCreatedException();
          }
          return userName;
        },
      );

  Future<void> upsertUserName(String name) => _openUserBox().then(
        (box) => box.put(_userKey, name),
      );
}
