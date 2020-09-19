abstract class SignInAction {}

abstract class SignInActionError implements SignInAction {}

class ShowMainContent implements SignInAction {}

class ShowInvalidCredentialsError implements SignInActionError {}

class NoUserCreatedError implements SignInActionError {}

class ShowGenericError implements SignInActionError {}

abstract class SignInState {}

//todo: This name is horrible, need to think in something better
class SignInFlow extends SignInState {
  SignInFlow({
    this.userName,
  });

  final String userName;
}

class Loading extends SignInState {}
