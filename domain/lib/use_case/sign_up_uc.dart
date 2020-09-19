import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:meta/meta.dart';

class SignUpUC extends UseCase<SignUpUCParams, void> {
  SignUpUC({
    @required this.authRepository,
  }) : assert(authRepository != null);

  final AuthDataRepository authRepository;

  @override
  Future<void> getRawFuture({SignUpUCParams params}) =>
      authRepository.signUp(params.username, params.password);
}

class SignUpUCParams {
  const SignUpUCParams({
    @required this.username,
    @required this.password,
  })  : assert(username != null),
        assert(password != null);

  final String username;
  final String password;
}
