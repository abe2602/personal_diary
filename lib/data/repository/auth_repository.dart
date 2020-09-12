import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:personal_diary/data/secure/auth_sds.dart';

class AuthRepository implements AuthDataRepository {
  const AuthRepository({
    @required this.authSDS,
  }) : assert(authSDS != null);

  final AuthSDS authSDS;

  @override
  Future<void> signIn(String nickname, String pin) => Future.value('');
}
