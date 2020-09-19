abstract class SignInAction {}

abstract class SignInActionError implements SignInAction {}

class ShowMainContent implements SignInAction {}

class ShowInvalidCredentialsError implements SignInActionError {}

class NoUserCreatedError implements SignInActionError {}

class ShowGenericError implements SignInActionError {}

abstract class SignInState {}

class Idle extends SignInState {}

class Loading extends SignInState {}
