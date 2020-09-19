import 'package:domain/exceptions.dart';
import 'package:hive/hive.dart';

class AuthCDS {
  static const _userKey = 'userKey';

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