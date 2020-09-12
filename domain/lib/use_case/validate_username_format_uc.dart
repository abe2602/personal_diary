import 'dart:async';

import 'package:domain/exceptions.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:meta/meta.dart';

class ValidateUsernameFormatUC
    extends UseCase<ValidateUsernameFormatUCParams, void> {

  @override
  Future<void> getRawFuture({ValidateUsernameFormatUCParams params}) {
    final username = params.username ?? '';
    final completer = Completer();

    if (username.isEmpty) {
      completer.completeError(EmptyFormFieldException());
      return completer.future;
    } else if(username.contains(' ') || username.length > 12) {
      completer.completeError(InvalidFormFieldException());
    } else {
      completer.complete();
    }

    return completer.future;
  }
}

class ValidateUsernameFormatUCParams {
  const ValidateUsernameFormatUCParams({
    @required this.username,
  });

  final String username;
}
