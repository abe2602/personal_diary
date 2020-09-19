import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:personal_diary/data/secure/auth_sds.dart';

class AuthRepository implements AuthDataRepository {
  const AuthRepository({
    @required this.authSDS,
  }) : assert(authSDS != null);

  final AuthSDS authSDS;

  @override
  Future<void> signIn(String password) => authSDS.getUserName().then(
        (name) => authSDS.getPassword(name).then((savedPassword) {
          if (savedPassword != password) {
            throw InvalidCredentialsException();
          }
        }),
      );

  @override
  Future<void> signUp(String username, String password) => Future.wait(
        [
          authSDS.upsertPassword(username, password),
          authSDS.upsertUserName(username),
        ],
        eagerError: true,
      );
}
