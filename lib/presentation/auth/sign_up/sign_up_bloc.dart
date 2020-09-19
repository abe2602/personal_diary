import 'package:flutter/foundation.dart';
import 'package:domain/use_case/validate_password_format_uc.dart';
import 'package:domain/use_case/validate_username_format_uc.dart';
import 'package:domain/use_case/validate_confirm_password_format_uc.dart';
import 'package:domain/use_case/sign_up_uc.dart';
import 'package:personal_diary/presentation/auth/sign_up/sign_up_models.dart';
import 'package:personal_diary/presentation/common/input_status_vm.dart';
import 'package:personal_diary/presentation/common/subscription_utils.dart';
import 'package:personal_diary/presentation/common/view_utils.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc with SubscriptionBag {
  SignUpBloc({
    @required this.validatePasswordFormatUC,
    @required this.validateUsernameFormatUC,
    @required this.validateConfirmPasswordFormatUC,
    @required this.signUpUC,
  })  : assert(validatePasswordFormatUC != null),
        assert(signUpUC != null) {
    _onPasswordFocusLostSubject
        .listen(
          (_) => _validatePassword(_passwordInputStatusSubject),
        )
        .addTo(subscriptionsBag);

    _onNameFocusLostSubject
        .listen(
          (_) => _validateUsername(_nameInputStatusSubject),
        )
        .addTo(subscriptionsBag);

    _onConfirmPasswordFocusLostSubject
        .listen(
          (_) => _validateConfirmPassword(_confirmPasswordInputStatusSubject),
        )
        .addTo(subscriptionsBag);

    _onSignUpSubject
        .flatMap(
          (_) => Future.wait([
            _validateUsername(_nameInputStatusSubject),
            _validateConfirmPassword(_confirmPasswordInputStatusSubject),
            _validatePassword(_passwordInputStatusSubject),
          ]).asStream(),
        )
        .flatMap(
          (_) => _signUp(),
        )
        .listen(_onNewStateSubject.add)
        .addTo(subscriptionsBag);
  }

  final ValidatePasswordFormatUC validatePasswordFormatUC;
  final ValidateUsernameFormatUC validateUsernameFormatUC;
  final ValidateConfirmPasswordFormatUC validateConfirmPasswordFormatUC;
  final SignUpUC signUpUC;

  // State
  final _onNewStateSubject = BehaviorSubject<SignUpState>.seeded(Idle());

  Stream<SignUpState> get onNewState => _onNewStateSubject.stream;

  // Actions
  final _onNewActionSubject = PublishSubject<SignUpAction>();

  Stream<SignUpAction> get onNewAction => _onNewActionSubject.stream;

  // Sign Up
  final _onSignUpSubject = PublishSubject<void>();

  Sink<void> get onSignUpSink => _onSignUpSubject.sink;

  // Password
  final _passwordInputStatusSubject = BehaviorSubject<InputStatusVM>();

  Stream<InputStatusVM> get passwordInputStatusStream =>
      _passwordInputStatusSubject.stream;

  final _onPasswordChangedSubject = BehaviorSubject<String>();

  Sink<String> get onPasswordChangedSink => _onPasswordChangedSubject.sink;

  String get _passwordValue => _onPasswordChangedSubject.stream.value;

  final _onPasswordFocusLostSubject = PublishSubject<void>();

  Sink<void> get onPasswordFocusLostSink => _onPasswordFocusLostSubject.sink;

  // Password Confirmation
  final _confirmPasswordInputStatusSubject = BehaviorSubject<InputStatusVM>();

  Stream<InputStatusVM> get confirmPasswordInputStatusStream =>
      _confirmPasswordInputStatusSubject.stream;

  final _onConfirmPasswordChangedSubject = BehaviorSubject<String>();

  Sink<String> get onConfirmPasswordChangedSink =>
      _onConfirmPasswordChangedSubject.sink;

  String get _confirmPasswordValue =>
      _onConfirmPasswordChangedSubject.stream.value;

  final _onConfirmPasswordFocusLostSubject = PublishSubject<void>();

  Sink<void> get onConfirmPasswordFocusLostSink =>
      _onConfirmPasswordFocusLostSubject.sink;

  // Name
  final _nameInputStatusSubject = BehaviorSubject<InputStatusVM>();

  Stream<InputStatusVM> get nameInputStatusStream =>
      _nameInputStatusSubject.stream;

  final _onNameChangedSubject = BehaviorSubject<String>();

  Sink<String> get onNameChangedSink => _onNameChangedSubject.sink;

  String get _nameValue =>
      _onNameChangedSubject.stream.value?.trimRight()?.trimLeft();

  final _onNameFocusLostSubject = PublishSubject<void>();

  Sink<void> get onNameFocusLostSink => _onNameFocusLostSubject.sink;

  // Functions
  Future<void> _validatePassword(Sink<InputStatusVM> sink) =>
      validatePasswordFormatUC
          .getFuture(
            params: ValidatePasswordFormatUCParams(password: _passwordValue),
          )
          .addStatusToSink(sink);

  Future<void> _validateUsername(Sink<InputStatusVM> sink) =>
      validateUsernameFormatUC
          .getFuture(
            params: ValidateUsernameFormatUCParams(username: _nameValue),
          )
          .addStatusToSink(sink);

  Future<void> _validateConfirmPassword(Sink<InputStatusVM> sink) =>
      validateConfirmPasswordFormatUC
          .getFuture(
            params: ValidateConfirmPasswordFormatUCParams(
                password: _passwordValue,
                confirmPassword: _confirmPasswordValue),
          )
          .addStatusToSink(sink);

  Stream<SignUpState> _signUp() async* {
    yield Loading();

    try {
      await signUpUC.getFuture(
        params: SignUpUCParams(
          username: _nameValue,
          password: _passwordValue,
        ),
      );

      _onNewActionSubject.add(
        ShowMainContent(),
      );
    } catch (error) {
      yield Idle();

      _onNewActionSubject.add(
        ShowSignUpGenericError(),
      );
    }
  }

  void dispose() {
    _onNewStateSubject.close();
    _onNewActionSubject.close();
    _onSignUpSubject.close();
    _passwordInputStatusSubject.close();
    _onPasswordChangedSubject.close();
    _onPasswordFocusLostSubject.close();
    _confirmPasswordInputStatusSubject.close();
    _onConfirmPasswordChangedSubject.close();
    _onConfirmPasswordFocusLostSubject.close();
    _nameInputStatusSubject.close();
    _onNameChangedSubject.close();
    _onNameFocusLostSubject.close();
  }
}
