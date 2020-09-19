import 'dart:async';

import 'package:domain/exceptions.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:meta/meta.dart';

class ValidateUsernameFormatUC
    extends UseCase<ValidateUsernameUCParams, void> {

  @override
  Future<void> getRawFuture({ValidateUsernameUCParams params}) {
    final username = params.username ?? '';
    final completer = Completer();

    if (username.isEmpty) {
      completer.completeError(EmptyFormFieldException());
      return completer.future;
    } else if(username.length > 101) {
      completer.completeError(InvalidFormFieldException());
    } else {
      completer.complete();
    }

    return completer.future;
  }
}

class ValidateUsernameUCParams {
  const ValidateUsernameUCParams({
    this.username,
  });

  final String username;
}
