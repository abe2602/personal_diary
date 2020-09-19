import 'dart:async';

import 'package:domain/exceptions.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:meta/meta.dart';

class ValidatePasswordUC
    extends UseCase<ValidatePasswordUCParams, void> {
  @override
  Future<void> getRawFuture({ValidatePasswordUCParams params}) {
    final completer = Completer();
    final password = params.password ?? '';

    if (password.isEmpty) {
      completer.completeError(EmptyFormFieldException());
      return completer.future;
    }

    final matches = RegExp('^[0-9]{6}\$').allMatches(password);

    final isValid = matches
        .any((match) => match.start == 0 && match.end == password.length);

    if (!isValid) {
      completer.completeError(InvalidFormFieldException());
    } else {
      completer.complete();
    }

    return completer.future;
  }
}

class ValidatePasswordUCParams {
  const ValidatePasswordUCParams({
    this.password,
  });

  final String password;
}
