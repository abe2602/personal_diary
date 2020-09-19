abstract class SignUpAction {}
abstract class SignUpActionError implements SignUpAction{}

class ShowMainContent implements SignUpAction {}

class ShowSignUpGenericError implements SignUpActionError {
}

abstract class SignUpState {}

class Idle extends SignUpState {}

class Loading extends SignUpState {}