import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:meta/meta.dart';

class GetUserNameUC extends UseCase<void, String> {
  GetUserNameUC({
    @required this.authRepository,
  })  : assert(authRepository != null);

  final AuthDataRepository authRepository;

  @override
  Future<String> getRawFuture({void params}) =>
      authRepository.getUserName();
}

