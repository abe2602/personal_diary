import 'dart:async';

import 'package:domain/exceptions.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:meta/meta.dart';

class ValidateConfirmPasswordFormatUC
    extends UseCase<ValidateConfirmPasswordFormatUCParams, void> {
  @override
  Future<void> getRawFuture({ValidateConfirmPasswordFormatUCParams params}) {
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

class ValidateConfirmPasswordFormatUCParams {
  const ValidateConfirmPasswordFormatUCParams({
    @required this.password,
    @required this.confirmPassword,
  });

  final String password;
  final String confirmPassword;
}
