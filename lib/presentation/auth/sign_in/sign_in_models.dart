abstract class SignInAction {}

class ShowMainContent implements SignInAction {}

class ShowInvalidCredentialsError implements SignInAction {}

class ShowSignInError implements SignInAction {
}

abstract class SignInState {}

class Idle extends SignInState {}

class Loading extends SignInState {}
