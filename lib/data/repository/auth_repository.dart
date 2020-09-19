import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:personal_diary/data/cache/auth_cds.dart';
import 'package:personal_diary/data/secure/auth_sds.dart';

class AuthRepository implements AuthDataRepository {
  const AuthRepository({
    @required this.authSDS,
    @required this.authCDS,
  })  : assert(authSDS != null),
        assert(authCDS != null);

  final AuthSDS authSDS;
  final AuthCDS authCDS;

  @override
  Future<void> signIn(String password) => authCDS.getUserName().then(
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
          authCDS.upsertUserName(username),
        ],
        eagerError: true,
      );

  @override
  Future<String> getUserName() => authCDS.getUserName();
}
