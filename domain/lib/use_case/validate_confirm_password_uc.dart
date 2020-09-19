import 'dart:async';

import 'package:domain/exceptions.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:meta/meta.dart';

class ValidateConfirmPasswordUC
    extends UseCase<ValidateConfirmPasswordUCParams, void> {
  @override
  Future<void> getRawFuture({ValidateConfirmPasswordUCParams params}) {
    final completer = Completer();
    final password = params.password ?? '';
    final confirmPassword = params.confirmPassword ?? '';

    if (confirmPassword.isEmpty ) {
      completer.completeError(EmptyFormFieldException());
      return completer.future;
    }

    if (password != confirmPassword) {
      completer.completeError(InvalidFormFieldException());
    } else {
      completer.complete();
    }

    return completer.future;
  }
}

class ValidateConfirmPasswordUCParams {
  const ValidateConfirmPasswordUCParams({
    this.password,
    this.confirmPassword,
  });

  final String password;
  final String confirmPassword;
}
